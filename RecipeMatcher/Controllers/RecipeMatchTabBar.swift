//  RecipesTabBar.swift
//  RecipeMatcher

import UIKit

class RecipeMatchTabBar: UITabBarController {
    
    lazy var navController1 = UINavigationController(rootViewController: SearchRecipesVC())
    
    lazy var navController2 = UINavigationController(rootViewController: FavRecipesVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navControllersSetup()
        
    }
    
    func navControllersSetup() {
        navController1.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        
        navController2.tabBarItem = UITabBarItem(title: "FAVORITES", image: UIImage(systemName: "folder.fill.badge.plus"), tag: 1)
        self.viewControllers = [navController1, navController2]
    }
}
