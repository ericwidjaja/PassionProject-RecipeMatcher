//  RecipesTabBar.swift
//  RecipeMatcher

import UIKit

class RecipeMatchTabBar: UITabBarController {
    
    //MARK: - Properties
    lazy var navController1 = UINavigationController(rootViewController: SearchRecipesVC())
    lazy var navController2 = UINavigationController(rootViewController: FavRecipesVC())
    lazy var navController3 = UINavigationController(rootViewController: MyCookbookCollectionsVC())
    lazy var navController4 = UINavigationController(rootViewController: UserProfileVC())
    
    //MARK: - Functions
    private func tabBarSetup() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.standardAppearance = appearance
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navControllersSetup()
        tabBarSetup()
    }
    
    func navControllersSetup() {
        navController1.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        navController2.tabBarItem = UITabBarItem(title: "FAVORITES", image: UIImage(systemName: "heart.fill"), tag: 1)
        navController3.tabBarItem = UITabBarItem(title: "COLLECTIONS", image: UIImage(systemName: "folder.fill.badge.plus"), tag: 2)
        navController4.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.circle"), tag: 3)
        
        self.viewControllers = [navController1, navController2, navController3, navController4]
    }
}

