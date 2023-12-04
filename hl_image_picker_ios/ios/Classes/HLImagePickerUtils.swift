import AVFoundation
import Photos
import MobileCoreServices

class HLImagePickerUtils {
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func generateVideoThumbnail(from videoURL: URL, quality: Double? = nil, format: String? = nil) -> String? {
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            let thumbnailImage = UIImage(cgImage: thumbnailCGImage)
            var data: Data?
            var fileName: String
            let randomId = randomString(length: 10)
            if "png" == format {
                data = thumbnailImage.pngData()
                fileName = "hl_image_picker_\(randomId).png"
            } else {
                data = thumbnailImage.jpegData(compressionQuality: CGFloat(quality ?? 0.9))
                fileName = "hl_image_picker_\(randomId).jpg"
            }
            
            guard let data = data else {
                return nil
            }
            
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let thumbnailURL = documentsDirectory.appendingPathComponent(fileName)
            
            try data.write(to: thumbnailURL)
            
            return thumbnailURL.path
        } catch {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
    
    static func getFileSize(at filePath: String) -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let fileSize = fileAttributes[FileAttributeKey.size] as? UInt64 {
                return fileSize
            }
        } catch {
            print("Error getting file size: \(error)")
        }
        return 0
    }
    
    static func copyImage(_ image: UIImage, quality: Double? = nil, format: String? = nil, targetSize: CGSize? = nil, id: String? = nil) -> [String : Any]? {
        var data: Data?
        var fileName: String
        let randomId = randomString(length: 10)
        var newImage = image
        if let targetSize = targetSize {
            newImage = resizeImage(image, targetSize: targetSize)
        }
        if "png" == format {
            data = newImage.pngData()
            fileName = "hl_image_picker_\(randomId).png"
        } else {
            data = newImage.jpegData(compressionQuality: CGFloat(quality ?? 0.9))
            fileName = "hl_image_picker_\(randomId).jpg"
        }
        
        guard let data = data else {
            return nil
        }
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL)
            let media = [
                "path": fileURL.path,
                "id": id ?? fileName,
                "name": fileName,
                "mimeType": "image/jpeg",
                "size": getFileSize(at: fileURL.path),
                "height": Int(newImage.size.width) as NSNumber,
                "width": Int(newImage.size.height) as NSNumber,
                "type": "image",
            ] as [String : Any]
            return media
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    static func getMimeType(url: URL) -> String? {
        let ext = url.pathExtension
        if !ext.isEmpty {
            let UTIRef = UTTypeCreatePreferredIdentifierForTag("public.filename-extension" as CFString, ext as CFString, nil)
            let UTI = UTIRef?.takeUnretainedValue()
            UTIRef?.release()
            if let UTI = UTI {
                guard let MIMETypeRef = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType) else { return nil }
                let MIMEType = MIMETypeRef.takeUnretainedValue()
                MIMETypeRef.release()
                return MIMEType as String
            }
        }
        return nil
    }
    
    static func getVideoSize(asset: AVAsset) -> CGSize {
        guard let videoTrack = asset.tracks(withMediaType: .video).first else {
            return CGSize.zero
        }
        
        let videoSize = videoTrack.naturalSize
        let videoTransform = videoTrack.preferredTransform
        
        // Check if the video is rotated
        if videoTransform.a == 0 && videoTransform.b == 1 && videoTransform.c == -1 && videoTransform.d == 0 {
            // Video is in portrait orientation
            return CGSize(width: videoSize.height, height: videoSize.width)
        } else {
            // Video is in landscape orientation
            return videoSize
        }
    }
    
    static func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            // The user has already granted permission.
            completion(true)
        case .notDetermined:
            // Permission has not been requested yet. Request permission.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        case .denied, .restricted:
            // Permission was denied or restricted.
            completion(false)
        @unknown default:
            // Handle any future cases if needed.
            completion(false)
        }
    }
    
    static func getImageData(phasset: PHAsset?, resultHandler: @escaping (Data?, String?, UIImage.Orientation, [AnyHashable : Any]?) -> Void) {
        guard let asset = phasset else { return }
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic
        options.version = .current
        options.resizeMode = .exact
        PHCachingImageManager().requestImageData(for: asset, options: options, resultHandler: resultHandler)
    }
    
    static func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let maxWidth = targetSize.width
        let maxHeight = targetSize.height

        if maxWidth == 0 || maxHeight == 0 {
            return image
        }
        
        if image.size.width <= maxWidth && image.size.height <= maxHeight {
            return image
        }
        
        var newSize = CGSize(width: image.size.width, height: image.size.height)
        if maxWidth < newSize.width {
            newSize = CGSize(width: maxWidth, height: (maxWidth / newSize.width) * newSize.height)
        }
        if maxHeight < newSize.height {
            newSize = CGSize(width: (maxHeight / newSize.height) * newSize.width, height: maxHeight)
        }
        
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return image
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
