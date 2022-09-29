//
//  ItemDetailsViewController.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 26/09/22.
//

import UIKit
import JGProgressHUD
class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var item: Item!
    var itemImages:[UIImage] = []
    let hud = JGProgressHUD(style: .dark)
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    let cellHeight: CGFloat = 196.0
    let itemsPerRow: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadPictures()
     }
    
    //MARK: Download Pictures
    
    private func downloadPictures() {
        if item != nil && item.imageLinks != nil {
            downloadImagesFromFirebase(imageUrls: item.imageLinks) { (allImages) in
                if allImages.count > 0 {
                    self.itemImages = allImages as! [UIImage]
                    self.imagesCollectionView.reloadData()
                }
            }
        }
    }
    
    
    //MARK: SetupUI
    private func setupUI() {
        if item != nil {
            self.title = item.name
            nameLabel.text = item.name
            priceLabel.text = " ₹ \(item.price ?? 0.00)"
            //priceLabel.text = convertToCurrency(item.price)
            descriptionLabel.text = item.description
        }
    }
    
}

