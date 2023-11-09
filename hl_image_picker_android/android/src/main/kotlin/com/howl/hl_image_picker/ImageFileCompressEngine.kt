package com.howl.hl_image_picker

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Environment
import androidx.exifinterface.media.ExifInterface
import com.luck.picture.lib.engine.CompressFileEngine
import com.luck.picture.lib.interfaces.OnKeyValueResultCallbackListener
import java.io.File
import java.io.IOException
import java.util.UUID


class ImageFileCompressEngine(
    private val quality: Double?,
    private val format: String?,
    private val maxWidth: Int,
    private val maxHeight: Int
) : CompressFileEngine {

    override fun onStartCompress(
        context: Context,
        source: ArrayList<Uri>,
        call: OnKeyValueResultCallbackListener
    ) {
        for (uri in source) {
            try {
                val imageDimensions = getImageDimensions(uri, context)
                var width = imageDimensions[0]
                var height = imageDimensions[1]

                if (maxWidth < width && maxWidth != 0) {
                    height = (maxWidth.toFloat() / width * height).toInt()
                    width = maxWidth
                }

                if (maxHeight < height && maxHeight != 0) {
                    width = (maxHeight.toFloat() / height * width).toInt()
                    height = maxHeight
                }

                context.contentResolver.openInputStream(uri).use { imageStream ->
                    val randomId = UUID.randomUUID().toString().substring(0, 10)
                    val fileName: String
                    val imageDirectory = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
                    if (imageDirectory?.exists() == false) {
                        imageDirectory.mkdirs()
                    }
                    var compressFormat = Bitmap.CompressFormat.JPEG
                    if (format == "png") {
                        fileName = "hl_image_picker_$randomId.png"
                        compressFormat = Bitmap.CompressFormat.PNG
                    } else {
                        fileName = "hl_image_picker_$randomId.jpg"
                    }
                    val originalOrientation = getOrientation(uri, context)
                    var bitmap = BitmapFactory.decodeStream(imageStream)
                    bitmap = if (needToSwapDimension(originalOrientation)) {
                        Bitmap.createScaledBitmap(bitmap, height, width, true)
                    } else {
                        Bitmap.createScaledBitmap(bitmap, width, height, true)
                    }

                    val file = File(imageDirectory, fileName)

                    context.contentResolver.openOutputStream(Uri.fromFile(file)).use { os ->
                        val compressQuality = ((quality ?: 0.9) * 100).toInt()
                        bitmap.compress(compressFormat, compressQuality, os)
                    }

                    setOrientation(file, originalOrientation)
                    call.onCallback(uri.toString(), file.absolutePath)
                }
            } catch (e: Exception) {
                call.onCallback(uri.toString(), null)
            }
        }
    }

    private fun getImageDimensions(uri: Uri, context: Context): IntArray {
        return try {
            context.contentResolver.openInputStream(uri)?.use { inputStream ->
                val orientation = getOrientation(uri, context)
                val options = BitmapFactory.Options().apply {
                    inJustDecodeBounds = true
                }
                BitmapFactory.decodeStream(inputStream, null, options)
                if (needToSwapDimension(orientation)) {
                    intArrayOf(options.outHeight, options.outWidth)
                } else {
                    intArrayOf(options.outWidth, options.outHeight)
                }
            } ?: intArrayOf(0, 0) // in case openInputStream returns null
        } catch (e: IOException) {
            intArrayOf(0, 0)
        }
    }

    private fun needToSwapDimension(orientation: String?): Boolean {
        return orientation == ExifInterface.ORIENTATION_ROTATE_90.toString() ||
                orientation == ExifInterface.ORIENTATION_ROTATE_270.toString()
    }

    @Throws(IOException::class)
    private fun getOrientation(uri: Uri, context: Context): String? {
        context.contentResolver.openInputStream(uri)?.use { inputStream ->
            val exifInterface = ExifInterface(inputStream)
            return exifInterface.getAttribute(ExifInterface.TAG_ORIENTATION)
        }
        throw IOException("Could not open InputStream for URI: $uri")
    }

    @Throws(IOException::class)
    private fun setOrientation(file: File, orientation: String?) {
        if (orientation == ExifInterface.ORIENTATION_NORMAL.toString() ||
            orientation == ExifInterface.ORIENTATION_UNDEFINED.toString()
        ) {
            return
        }
        ExifInterface(file).apply {
            setAttribute(ExifInterface.TAG_ORIENTATION, orientation)
            saveAttributes()
        }
    }
}