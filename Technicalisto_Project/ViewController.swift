//
//  ViewController.swift
//  Technicalisto_Project
//
//  Created by Technicalisto .
//

import UIKit
import Photos
import BSImagePicker // pod

class ViewController: UIViewController ,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {

//---------------------------------------------------------------------------------------------------------

    var myImages:[Data]! = [Data]() // 1
    var SelectedAssets = [PHAsset]() // 2
    var photoArray = [UIImage]() // 3
    
    var pickerController: UIImagePickerController? // 4

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//---------------------------------------------------------------------------------------------------------
    
    @IBAction func deleteImageTapped(_ sender: UIButton) {
        
        self.myImages.remove(at: sender.tag)
        self.photoArray.remove(at: sender.tag)
        self.SelectedAssets.remove(at: sender.tag)
        
        self.collectionView.reloadData()

        
    }

//---------------------------------------------------------------------------------------------------------

    @IBAction func addImageTapped(_ sender: Any) {
      self.openPhoto()
    }
    
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
    
//---------------------------------------------------------------------------------------------------------

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
                // This for send images data to another view cntroller for make request
            self.myImages.append(data!)
            
            }
        
            DispatchQueue.main.async {
              self.collectionView.reloadData()
            }
        
        }
            
        print("complete photo array \(self.photoArray)")
    }

//---------------------------------------------------------------------------------------------------------

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myImages?.count ?? 0
    }
       
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ImageCVC
        
            cell.deleteBtnCell.tag = indexPath.row
            cell.imageCell.image = self.photoArray[indexPath.row]
            cell.imageCell.layer.cornerRadius = 12
            cell.imageCell.layer.masksToBounds = true
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 208, height: 200)
    }
    
//---------------------------------------------------------------------------------------------------------

}

