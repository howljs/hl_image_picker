package com.howl.hl_image_picker

import androidx.fragment.app.Fragment
import com.bumptech.glide.Glide
import com.luck.lib.camerax.SimpleCameraX
import com.luck.picture.lib.interfaces.OnCameraInterceptListener


internal class CameraInterceptListener : OnCameraInterceptListener {
    override fun openCamera(fragment: Fragment, cameraMode: Int, requestCode: Int) {
        val camera = SimpleCameraX.of()
        camera.isAutoRotation(true)
        camera.setCameraMode(cameraMode)
        camera.setVideoFrameRate(25)
        camera.setVideoBitRate(3 * 1024 * 1024)
        camera.isDisplayRecordChangeTime(true)
        camera.setImageEngine { context, url, imageView -> Glide.with(context).load(url).into(imageView) }
        camera.start(fragment.requireActivity(), fragment, requestCode)
    }
}