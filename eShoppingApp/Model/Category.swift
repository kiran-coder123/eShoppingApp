//
//  Category.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 22/09/22.
//

import Foundation
import UIKit

class Category {
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    }
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[kNAME] as! String
        image = UIImage(named: _dictionary[kIMAGENAME] as? String ?? "")
    }
}

//MARK: download category from firebase

func downloadCategoriesFromFirebase(completion: @escaping (_ categoryArr: [Category]) -> Void) {
    
    var categoryArr: [Category] = []
    
    firebaseReference(.Category).getDocuments { snapshot, error in
        guard let snapshot = snapshot else {
            completion(categoryArr)
            return
        }
        
        if !snapshot.isEmpty {
            
            for categoryDict in snapshot.documents {
                categoryArr.append(Category(_dictionary: categoryDict.data() as! NSDictionary))
            }
        }
        completion(categoryArr)
        
    }
}




//MARK: Save category function

func saveCategoryToFirebase(_ category: Category) {
    let id =  UUID().uuidString
    category.id = id
    firebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
    
}

//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
    return NSDictionary(objects: [category.id,category.name,category.imageName], forKeys: [kOBJECTID as NSCopying,kNAME  as NSCopying,kIMAGENAME  as NSCopying])
}
//
//// use only one time
//func createCategorySet() {
//    let womenClothing = Category(_name: "Women's clothing & Accessories", _imageName: "womenCloth")
//    let footWaer = Category(_name: "FootWaer", _imageName: "footWaer")
//    let electronics = Category(_name: "Electronics", _imageName: "electronics")
//    let menClothing = Category(_name: "Men's Clothing & Accessories", _imageName: "menCloth")
//    let health = Category(_name: "Health & Beauty", _imageName: "health")
//    let baby = Category(_name: "Baby Stuff", _imageName: "baby")
//    let home = Category(_name: "Home & Kitchen", _imageName: "home")
//    let car = Category(_name: "Automoniles & Motorcycles", _imageName: "car")
//    let luggage = Category(_name: "Luggage & Bags", _imageName: "luggage")
//    let jwellery = Category(_name: "Jwellery", _imageName: "jwellery")
//    let pet = Category(_name: "Pet Products", _imageName: "pet")
//    let industry = Category(_name: "Industry & Business", _imageName: "business")
//    let garden = Category(_name: "Garden Supplies", _imageName: "garden")
//    let camera = Category(_name: "Cameras & Optics", _imageName: "camera")
//    let book = Category(_name: "Books", _imageName: "book")
//
//    let arrCategory = [womenClothing,footWaer,electronics,menClothing,health,baby,home,car,luggage,jwellery,pet,industry,garden,camera,book]
//
//    for category in arrCategory {
//        saveCategoryToFirebase(category)
//    }
//
//
//}
