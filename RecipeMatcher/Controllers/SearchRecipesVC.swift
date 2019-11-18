//
//  SearchRecipesVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 11/3/19.
//  Copyright © 2019 Eric W. All rights reserved.
//

import UIKit

class SearchRecipesVC : UIViewController {
    
    //MARK: - Objects
    
    lazy var ingredientOneSearchBar: UISearchBar = {
        let mainSearchBar = UISearchBar()
        mainSearchBar.tag = 0
        mainSearchBar.placeholder = "Enter First Ingredient"
        mainSearchBar.setImage(UIImage(systemName: "1.magnifyingglass"), for: .search, state: .normal)
        return mainSearchBar
    }()
    
    lazy var ingredientTwoSearchBar: UISearchBar = {
        let mainSearchBar = UISearchBar()
        mainSearchBar.tag = 1
        mainSearchBar.placeholder = "Enter Second Ingredient"
        mainSearchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        return mainSearchBar
    }()
    
    lazy var objectsViewArray = [self.ingredientOneSearchBar, self.ingredientTwoSearchBar]
    
    
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        setDelegates()
        addViewsToSubView()
        setSearchBarsConstraints()
        
    }
    
//MARK:Add ViewsToSubviews
    private func addViewsToSubView() {
        for aView in objectsViewArray {
            view.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
// MARK: - Set Delegates
    private func setDelegates() {
        ingredientOneSearchBar.delegate = self
        ingredientTwoSearchBar.delegate = self
    }
    
//MARK: Set Constraints
    private func setSearchBarsConstraints() {
        NSLayoutConstraint.activate([
        ingredientOneSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
        ingredientOneSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
        ingredientOneSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
        ingredientTwoSearchBar.topAnchor.constraint(equalTo: ingredientOneSearchBar.bottomAnchor,constant: 15),
        ingredientTwoSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
        ingredientTwoSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15)])
    }
}

//MARK: Extensions

extension SearchRecipesVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        switch searchBar.tag {
        case 0:
            ingredientOneSearchBar.showsCancelButton = true
            ingredientOneSearchBar.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .search, state: .normal)
        case 1:
            ingredientTwoSearchBar.showsCancelButton = true
            ingredientTwoSearchBar.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .search, state: .normal)
        default:
            break
        }
        
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        switch searchBar.tag {
        case 0:
            ingredientOneSearchBar.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .search, state: .normal)
        case 1:
            ingredientOneSearchBar.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .search, state: .normal)
        default:
            break
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        switch searchBar.tag {
        case 0:
            ingredientOneSearchBar.showsCancelButton = false
//            searchStringQuery = ""
            searchBar.placeholder = ""
            ingredientOneSearchBar.resignFirstResponder()
            
        case 1:
            ingredientTwoSearchBar.showsCancelButton = false
            ingredientTwoSearchBar.resignFirstResponder()
            
        default:
            break
            
        }
    }
}
