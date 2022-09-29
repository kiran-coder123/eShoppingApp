//
//  CategoryCollectionViewCell.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 22/09/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImagesView: UIImageView!
    
    func generateCell(_ category: Category) {
        categoryNameLabel.text = category.name
        categoryImagesView.image = category.image
    }
    
    
}
