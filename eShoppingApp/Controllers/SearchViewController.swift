//
//  SearchViewController.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 26/09/22.
//

import UIKit
import NVActivityIndicatorView

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBackgroundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var searchResults:[Item] = []
    var activityIndicator: NVActivityIndicatorView?
    
    
    //MARK: Life cyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.tableFooterView  = UIView()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .lineSpinFadeLoader, color: .green, padding: nil)
    }
    
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        dismissKeyboard()
        showSearchField()
    }
    
    //MARK: Helpers methods
    
    private func emptyTextField() {
        searchTextField.text = ""
    }
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchButton.isEnabled = textField.text != ""
        
        if searchButton.isEnabled {
            searchButton.backgroundColor = .systemBlue
        } else {
            disableSearchButton()
        }
    }
    
    private func disableSearchButton(){
        searchButton.isEnabled = false
        searchButton.backgroundColor = .gray
    }
    
    private func showSearchField(){
        disableSearchButton()
        emptyTextField()
        animateSearchOptionIn()
    }
    
    //MARK: Animation
    
    private func animateSearchOptionIn() {
        UIView.animate(withDuration: 0.5) {
    self.searchBackgroundView.isHidden = !self.searchBackgroundView.isHidden
        }
    }
    
    // MARK: Activity indicator
    private func showLoadingIndicator() {
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    
    private func hideLoadingIndicator() {
        if activityIndicator != nil {
            self.view.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
      func showItemView(withItem: Item) {
          let itemVC = storyboard?.instantiateViewController(withIdentifier: "ItemDetailsViewController") as!  ItemDetailsViewController
          itemVC.item = withItem
           
          self.navigationController?.pushViewController(itemVC, animated: true)
 
          
    }
}
