//
//  UserProfileVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 9/19/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    
    
    //MARK: - Properties
    
    var userProfile = UserProfileView()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(userProfile)
        
    }
}
