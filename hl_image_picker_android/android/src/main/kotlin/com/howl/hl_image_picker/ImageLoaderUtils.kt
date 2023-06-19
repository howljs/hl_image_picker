package com.howl.hl_image_picker

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import com.luck.picture.lib.utils.ActivityCompatHelper.isDestroy

object ImageLoaderUtils {
    fun assertValidRequest(context: Context): Boolean {
        if (context is Activity) {
            val activity = context as Activity
            return !isDestroy(activity)
        } else if (context is ContextWrapper) {
            val contextWrapper = context as ContextWrapper
            if (contextWrapper.baseContext is Activity) {
                val activity = contextWrapper.baseContext as Activity
                return !isDestroy(activity)
            }
        }
        return true
    }
}