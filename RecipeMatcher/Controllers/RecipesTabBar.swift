//
//  RecipesTabBar.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 11/22/19.
//  Copyright © 2019 Eric W. All rights reserved.
//

import UIKit

class RecipesTabBar: UITabBarController {
    
        let navController = UINavigationController(rootViewController: SearchRecipesVC())

        let navController2 = UINavigationController(rootViewController: CollectionViewTabBarVC())

        

    override func viewDidLoad() {
        super.viewDidLoad()
        navController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)

        navController2.tabBarItem = UITabBarItem(title: "COLLECTION", image: UIImage(systemName: "folder.fill.badge.plus"), tag: 1)
        self.viewControllers = [navController, navController2]

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
