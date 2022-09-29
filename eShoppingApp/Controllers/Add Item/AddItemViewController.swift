//
//  AddItemViewController.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 23/09/22.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var category: Category!
    var gallery: GalleryController!
    var hud = JGProgressHUD(style: .light)
    var activityIndicator: NVActivityIndicatorView?
    var itemImages: [UIImage?] = []
    
    //MARK: View lifecycle
    
     override func viewDidLoad() {
        super.viewDidLoad()
         print(category.name)
     }
    
     
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .lineSpinFadeLoader, color: .green, padding: nil)
    }
    //MARK: Actions
    
    @IBAction func doneButtonClick(_ sender: Any) {
    
    dismissKeyboard()
        if fieldAreCompleted() {
           saveToFirebase()
            titleTextField.text = ""
            priceTextField.text = ""
            descriptionTextView.text = ""
        } else {
            self.hud.textLabel.text = "All fields are required!!"
            self.hud.textLabel.textColor = .red
            //self.hud.textLabel.tintColor = .red
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
       }
    }
    @IBAction func cameraButtonClick(_ sender: Any) {
       itemImages = []
        self.showGallery()
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
       
    }
    
    //MARK: Helpers
    
    private func fieldAreCompleted() -> Bool {
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    private func popTheView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Activity Indicator
    private func showLoadingIndicator() {
        
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
        }
        
    }
    private func hideLoadingIndicator() {
        
        if activityIndicator != nil {
            self.activityIndicator?.removeFromSuperview()
            activityIndicator?.stopAnimating()
        }
    }
    
    
    // MARK: Show image gallery
    
    private func showGallery() {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab,.cameraTab]
        Config.Camera.imageLimit = 5
        
        self.present(self.gallery, animated: true, completion: nil)
    }
     //MARK: Save Items
    private func saveToFirebase() {
        showLoadingIndicator()
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.categoryId = category.id
        item.price = Double(priceTextField.text!)
        item.description = descriptionTextView.text
    
        if itemImages.count > 0 {
            uploadImages(images: itemImages, itemId: item.id) { (itemImages) in
                item.imageLinks = itemImages
                saveItemsToFirestore(item)
                self.hideLoadingIndicator()
                self.popTheView()
            }
        } else {
            saveItemsToFirestore(item)
            popTheView()
        }
    }
}

