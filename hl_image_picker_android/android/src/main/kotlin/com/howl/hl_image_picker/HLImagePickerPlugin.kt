package com.howl.hl_image_picker

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import com.luck.picture.lib.basic.PictureSelector
import com.luck.picture.lib.config.PictureMimeType
import com.luck.picture.lib.config.SelectMimeType
import com.luck.picture.lib.config.SelectModeConfig
import com.luck.picture.lib.entity.LocalMedia
import com.luck.picture.lib.interfaces.OnResultCallbackListener
import com.luck.picture.lib.utils.MediaUtils
import com.yalantis.ucrop.UCrop
import com.yalantis.ucrop.model.AspectRatio
import com.yalantis.ucrop.view.CropImageView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File


/** HLImagePickerPlugin */
class HLImagePickerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var currentActivity: Activity? = null
    private lateinit var applicationContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hl_image_picker")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    private var flutterCall: MethodCall? = null
    private var mediaPickerResult: Result? = null

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "openPicker" -> {
                this.flutterCall = call
                this.mediaPickerResult = result
                openPicker()
            }

            "openCamera" -> {
                this.flutterCall = call
                this.mediaPickerResult = result
                openCamera()
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun openCamera() {
        val cameraType = when (flutterCall?.argument<String>("cameraType")) {
            "video" -> SelectMimeType.ofVideo()
            else -> SelectMimeType.ofImage()
        }
        val recordVideoMaxSecond = flutterCall?.argument<Int>("recordVideoMaxSecond") ?: 60
        PictureSelector.create(currentActivity)
                .openCamera(cameraType)
                .setCropEngine(getCropFileEngine())
                .setVideoThumbnailListener(getVideoThumbnail())
                .setRecordVideoMaxSecond(recordVideoMaxSecond)
                .forResultActivity(object : OnResultCallbackListener<LocalMedia> {
                    override fun onResult(result: ArrayList<LocalMedia>?) {
                        if (result != null) {
                            val media = result[0]
                            if (media.width == 0 || media.height == 0) {
                                if (PictureMimeType.isHasImage(media.mimeType)) {
                                    val imageExtraInfo = MediaUtils.getImageSize(applicationContext, media.path)
                                    media.width = imageExtraInfo.width
                                    media.height = imageExtraInfo.height
                                } else if (PictureMimeType.isHasVideo(media.mimeType)) {
                                    val imageExtraInfo = MediaUtils.getVideoSize(applicationContext, media.path)
                                    media.width = imageExtraInfo.width
                                    media.height = imageExtraInfo.height
                                }
                            }

                            val item = mutableMapOf<String, Any>()
                            item["id"] = media.path
                            item["name"] = media.fileName
                            item["mimeType"] = media.mimeType
                            item["size"] = media.size
                            item["type"] = "image"
                            if (media.mimeType.startsWith("video")) {
                                item["type"] = "video"
                                item["duration"] = media.duration.toDouble()
                                if (media.videoThumbnailPath != null) {
                                    item["thumbnail"] = media.videoThumbnailPath
                                }
                            }

                            if (media.isCut) {
                                item["width"] = media.cropImageWidth
                                item["height"] = media.cropImageHeight
                                item["path"] = media.cutPath
                            } else {
                                item["width"] = media.width
                                item["height"] = media.height
                                item["path"] = media.realPath
                            }
                            mediaPickerResult?.success(item)
                        } else {
                            mediaPickerResult?.error("CAMERA_ERROR", "Camera error", null)
                        }
                    }

                    override fun onCancel() {

                    }
                })
    }

    private fun openPicker() {
        val mediaType = when (flutterCall?.argument<String>("mediaType")) {
            "video" -> SelectMimeType.ofVideo()
            "image" -> SelectMimeType.ofImage()
            else -> SelectMimeType.ofAll()
        }
        val selectedAssets: MutableList<LocalMedia> = mutableListOf()
        val selectedIds = flutterCall?.argument<ArrayList<String>>("selectedIds") ?: ArrayList()
        for (i in 0 until selectedIds.size) {
            val localMedia: LocalMedia = LocalMedia.generateLocalMedia(applicationContext, selectedIds[i])
            selectedAssets.add(localMedia)
        }
        val numberOfColumn = flutterCall?.argument<Int>("numberOfColumn") ?: 3
        val enablePreview = flutterCall?.argument<Boolean>("enablePreview") ?: false
        val maxSelectedAssets = flutterCall?.argument<Int>("maxSelectedAssets") ?: 1
        val selectionMode = if (maxSelectedAssets == 1) SelectModeConfig.SINGLE else SelectModeConfig.MULTIPLE
        val usedCameraButton = flutterCall?.argument<Boolean>("usedCameraButton") ?: true
        val maxFileSize = flutterCall?.argument<Int>("maxFileSize") ?: 0
        val recordVideoMaxSecond = flutterCall?.argument<Int>("recordVideoMaxSecond") ?: 60
        val maxDuration = flutterCall?.argument<Int>("maxDuration") ?: 0

        PictureSelector.create(currentActivity)
                .openGallery(mediaType)
                .setMaxSelectNum(maxSelectedAssets)
                .setSelectionMode(selectionMode)
                .setImageSpanCount(numberOfColumn)
                .isPreviewImage(enablePreview)
                .isPreviewVideo(enablePreview)
                .isPreviewAudio(enablePreview)
                .setSelectedData(selectedAssets)
                .isWithSelectVideoImage(true)
                .setMaxVideoSelectNum(maxSelectedAssets)
                .setSelectMaxFileSize(maxFileSize.toLong())
                .isDisplayCamera(usedCameraButton)
                .setImageEngine(GlideEngine.createGlideEngine())
                .setCropEngine(getCropFileEngine())
                .setVideoThumbnailListener(getVideoThumbnail())
                .setRecordVideoMaxSecond(recordVideoMaxSecond)
                .setSelectMaxDurationSecond(maxDuration)
                .isEmptyResultReturn(true)
                .forResult(object : OnResultCallbackListener<LocalMedia?> {
                    override fun onResult(result: ArrayList<LocalMedia?>?) {
                        val mediaList: MutableList<Map<String, Any>> = mutableListOf()
                        result?.forEach { media ->
                            if (media != null) {
                                if (media.width == 0 || media.height == 0) {
                                    if (PictureMimeType.isHasImage(media.mimeType)) {
                                        val imageExtraInfo = MediaUtils.getImageSize(applicationContext, media.path)
                                        media.width = imageExtraInfo.width
                                        media.height = imageExtraInfo.height
                                    } else if (PictureMimeType.isHasVideo(media.mimeType)) {
                                        val imageExtraInfo = MediaUtils.getVideoSize(applicationContext, media.path)
                                        media.width = imageExtraInfo.width
                                        media.height = imageExtraInfo.height
                                    }
                                }

                                val item = mutableMapOf<String, Any>()
                                item["id"] = media.path
                                item["name"] = media.fileName
                                item["mimeType"] = media.mimeType
                                item["size"] = media.size
                                item["type"] = "image"
                                if (media.mimeType.startsWith("video")) {
                                    item["type"] = "video"
                                    item["duration"] = media.duration.toDouble()
                                    if (media.videoThumbnailPath != null) {
                                        item["thumbnail"] = media.videoThumbnailPath
                                    }
                                }

                                if (media.isCut) {
                                    item["width"] = media.cropImageWidth
                                    item["height"] = media.cropImageHeight
                                    item["path"] = media.cutPath
                                } else {
                                    item["width"] = media.width
                                    item["height"] = media.height
                                    item["path"] = media.realPath
                                }
                                mediaList.add(item)
                            }
                        }
                        mediaPickerResult?.success(mediaList)
                    }

                    override fun onCancel() {}
                })
    }

    private fun getCropFileEngine(): ImageFileCropEngine? {
        val isCropEnabled = flutterCall?.argument<Boolean>("cropping") ?: false
        val maxSelectedAssets = flutterCall?.argument<Int>("maxSelectedAssets") ?: 1
        if (!isCropEnabled || maxSelectedAssets != 1) {
            return null
        }
        val options = UCrop.Options()
        val aspectRatioX = flutterCall?.argument<Double>("ratioX")
        val aspectRatioY = flutterCall?.argument<Double>("ratioY")
        if (aspectRatioX != null && aspectRatioY != null) {
            options.withAspectRatio(aspectRatioX.toFloat(), aspectRatioY.toFloat())
        }
        val aspectRatioPresets = flutterCall?.argument<ArrayList<String>>("aspectRatioPresets")
        if (aspectRatioPresets != null) {
            val aspectRatioList = ArrayList<AspectRatio>()
            for (i in aspectRatioPresets.indices) {
                val preset = aspectRatioPresets[i]
                val aspectRatio = parseAspectRatio(preset)
                aspectRatioList.add(aspectRatio)
            }
            options.setAspectRatioOptions(0, *aspectRatioList.toTypedArray())
        }
        val compressQuality = flutterCall?.argument<Double>("compressQuality") ?: 0.9
        options.setCompressionQuality((compressQuality * 100).toInt())
        val compressFormat = flutterCall?.argument<String>("compressFormat")
        options.setCompressionFormat(if ("png".equals(compressFormat, ignoreCase = true)) Bitmap.CompressFormat.PNG else Bitmap.CompressFormat.JPEG)
        return ImageFileCropEngine(options)
    }

    private fun getVideoThumbnail(): VideoThumbnailEventListener? {
        val isExportThumbnail = flutterCall?.argument<Boolean>("isExportThumbnail") ?: false
        if (!isExportThumbnail) {
            return null
        }
        val externalFilesDir = applicationContext.getExternalFilesDir("")
        val customFile = File(externalFilesDir?.absolutePath, "Thumbnail")
        if (!customFile.exists()) {
            customFile.mkdirs()
        }
        val compressQuality = flutterCall?.argument<Double>("thumbnailCompressQuality") ?: 0.9
        val compressFormatStr = flutterCall?.argument<String>("thumbnailCompressFormat")
        val compressFormat = if ("png".equals(compressFormatStr, ignoreCase = true)) Bitmap.CompressFormat.PNG else Bitmap.CompressFormat.JPEG
        return VideoThumbnailEventListener(customFile.absolutePath + File.separator, (compressQuality * 100).toInt(), compressFormat)
    }

    private fun parseAspectRatio(name: String): AspectRatio {
        return when (name) {
            "square" -> {
                AspectRatio(null, 1.0f, 1.0f)
            }

            "3x2" -> {
                AspectRatio(null, 3.0f, 2.0f)
            }

            "4x3" -> {
                AspectRatio(null, 4.0f, 3.0f)
            }

            "5x3" -> {
                AspectRatio(null, 5.0f, 3.0f)
            }

            "5x4" -> {
                AspectRatio(null, 5.0f, 4.0f)
            }

            "7x5" -> {
                AspectRatio(null, 7.0f, 5.0f)
            }

            "16x9" -> {
                AspectRatio(null, 16.0f, 9.0f)
            }

            else -> {
                val aspectTitle = "Original"
                AspectRatio(aspectTitle, CropImageView.SOURCE_IMAGE_ASPECT_RATIO, 1.0f)
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        currentActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        currentActivity = null
    }
}
