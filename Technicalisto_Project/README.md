
# Technicalisto

## How to capture multi images as Data/PHAsset/UIImage and display it

1. Create your pod file and install :

    pod 'BSImagePicker'

2. in Info.plist add :

    NSPhotoLibraryUsageDescription

3. Create your design with collectionView to appear image on ot.

4. In ViewController Define vars like you want like this : 

    var myImages:[Data]! = [Data]() 
    var SelectedAssets = [PHAsset]() 
    var photoArray = [UIImage]() 
    
5. For call method to open image

    func openPhoto() {
        
    let imagePicker = ImagePickerController()
        
    presentImagePicker(imagePicker, select: { (asset) in

    }, deselect: { (asset) in
        
    }, cancel: { (assets) in

    }, finish: { (assets) in

    for i in 0..<assets.count {
        self.SelectedAssets.append(assets[i])
    }
        self.convertAssetsToImages()
    })
 }
 
6. If you want to convertvAssetsvTo Images use method such as :

    func convertAssetsToImages() -> Void {
       
    if SelectedAssets.count != 0 {
        
        self.myImages.removeAll()
        self.photoArray.removeAll()
        
        for i in 0..<SelectedAssets.count {
            
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: option, resultHandler: { (result, info) -> Void in
                thumbnail = result!
            })
            
            let data = thumbnail.jpegData(compressionQuality: 0.7)
            let newImage = UIImage(data: data!)
            self.photoArray.append(newImage! as UIImage)

            self.myImages.append(data!)
            
            }
        
            DispatchQueue.main.async {
              self.collectionView.reloadData()
            }
        
        }
            
     }

### Thanks

