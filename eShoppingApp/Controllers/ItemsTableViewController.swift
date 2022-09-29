//
//  ItemsTableViewController.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 22/09/22.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var category: Category?
    var itemArray: [Item] = []
    var item: [Item]!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = category?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if category != nil {
        //TODO: download items
            loadItems()
            
        }
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        cell.generateCell(itemArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.showItemView(itemArray[indexPath.row])
    }
    
    //MARK: NAVIGATION
    private func showItemView(_ item: Item) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
        detailsVC.item = item
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            let addItemVC = segue.destination as! AddItemViewController
            addItemVC.category = category!
        }
    }
   //MARK: Load Items
    private func loadItems() {
        downloadItemsFromFirebase(withCategoryId: category!.id) { (allItems) in
            self.itemArray = allItems
            self.tableView.reloadData()
        }
    }

}
