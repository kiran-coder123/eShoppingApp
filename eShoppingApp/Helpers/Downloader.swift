//
//  Downloader.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 23/09/22.
//

import Foundation
import UIKit
import FirebaseStorage

let storage = Storage.storage()

func uploadImages(images:[UIImage?],itemId: String, completion: @escaping(_ imageLinks: [String]) -> Void) {
    
    // check if Internet is available
    if Reachability.HasConnection() {
        
        var uplodedImageCount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        
        for image in images {
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image?.jpegData(compressionQuality: 0.5)
            
            saveImageInFirebase(imageData: imageData!, fileName: fileName) { (imageLink) in
                if imageLink != nil {
                    imageLinkArray.append(imageLink!)
                    uplodedImageCount += 1
                    
                    if uplodedImageCount == images.count {
                        completion(imageLinkArray)
                    }
                }
            }
            
            nameSuffix += 1
        }
        
    } else {
         print("no internet connection")
    }
}
func saveImageInFirebase(imageData: Data, fileName: String, completion:  @escaping (_ imageLink: String?) -> Void) {
    var task: StorageUploadTask!
    let storageRef = Storage.storage().reference(forURL:kFILEREFERENCE).child(fileName)
   
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
         
        task.removeAllObservers()
        
        if error != nil {
            print("Error uploading image",error!.localizedDescription)
            completion(nil)
            return 
        }
        
        storageRef.downloadURL { (url, error) in
            guard let downloadUrl = url else  {
                completion(nil)
                return
            }
            completion(downloadUrl.absoluteString)
        }
        
        
    })
}
//MARK: Download Images From Firebase
func downloadImagesFromFirebase(imageUrls: [String], completion: @escaping (_ images: [UIImage?]) -> Void) {
    var imageArray: [UIImage] = []
    var downloadCounter = 0
    
    for link in imageUrls {
        let url = NSURL(string: link)
        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
        downloadQueue.async {
             downloadCounter += 1
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                imageArray.append(UIImage(data: data! as Data)!)
                if downloadCounter == imageArray.count {
                    DispatchQueue.main.async {
                        completion(imageArray)
                    }
                }
            } else {
                print("could not download images from firebase")
                completion(imageArray)
            }
            
        }
    }
}
