//
//  CategoryCollectionViewController.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 22/09/22.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {

    var categoryArr: [Category] = []
    
      let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
      let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCategories()
    }
    
    //MARK: Collectionview DataSource and Delegate methods

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.generateCell(categoryArr[indexPath.row])
        return cell
    }
    
    //MARK: CollectionView Delegate methods
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "categoryToItemSegue", sender: categoryArr[indexPath.row])
    }
    
    
    
    //MARK: download categeries
    
    private func loadCategories() {
        downloadCategoriesFromFirebase { (allCategories) in
            print("we have",allCategories.count)
            self.categoryArr = allCategories
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToItemSegue" {
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category
        }
    }
    
    
    
}
