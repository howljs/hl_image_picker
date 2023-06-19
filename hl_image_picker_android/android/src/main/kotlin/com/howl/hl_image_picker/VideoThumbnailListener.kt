package com.howl.hl_image_picker

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.luck.picture.lib.interfaces.OnKeyValueResultCallbackListener
import com.luck.picture.lib.interfaces.OnVideoThumbnailEventListener
import com.luck.picture.lib.utils.PictureFileUtils
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class VideoThumbnailEventListener(private val targetPath: String, private val compressQuality: Int, private val compressFormat: Bitmap.CompressFormat) : OnVideoThumbnailEventListener {
    override fun onVideoThumbnail(context: Context, videoPath: String, call: OnKeyValueResultCallbackListener) {
        Glide.with(context)
                .asBitmap()
                .sizeMultiplier(0.6F)
                .load(videoPath)
                .into(object : CustomTarget<Bitmap>() {
                    override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
                        val stream = ByteArrayOutputStream()
                        resource.compress(compressFormat, compressQuality, stream)
                        var fos: FileOutputStream? = null
                        var result: String? = null
                        try {
                            val targetFile = File(targetPath, "media_picker_" + System.currentTimeMillis() + ".jpg")
                            fos = FileOutputStream(targetFile)
                            fos.write(stream.toByteArray())
                            fos.flush()
                            result = targetFile.absolutePath
                        } catch (e: IOException) {
                            e.printStackTrace()
                        } finally {
                            PictureFileUtils.close(fos)
                            PictureFileUtils.close(stream)
                        }
                        call.onCallback(videoPath, result)
                    }

                    override fun onLoadCleared(placeholder: Drawable?) {
                        call.onCallback(videoPath, "")
                    }
                })
    }
}