//
//  ImagesCollectionViewCell.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 26/09/22.
//

import UIKit
import Gallery

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scollableImageView: UIImageView!
   
    
   
    
  
    
    func setupImagesWith(itemImage: UIImage) {
        scollableImageView.image = itemImage
    }
   
}
