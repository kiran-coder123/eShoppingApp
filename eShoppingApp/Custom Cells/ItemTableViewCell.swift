//
//  ItemTableViewCell.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 24/09/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell, UITextViewDelegate{

    //MARK: Outlets
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func generateCell(_ item: Item) {
        nameLabel.text = item.name
        priceLabel.text = "₹ \(item.price!)"
       // priceLabel.text = convertToCurrency(item.price)
         priceLabel.adjustsFontSizeToFitWidth = true
        
        descriptionLabel.text = item.description
        
    if item.imageLinks != nil && item.imageLinks.count > 0 {
        downloadImagesFromFirebase(imageUrls: [item.imageLinks.first!]) { images in
                DispatchQueue.main.async {
                    self.itemImageView.image = images.first as? UIImage
                }
            }
        }
        
    }
}
