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
    
    //MARK: - Functions
    
    private func blurEffect() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "MainScreen")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userProfile)
        view.backgroundColor = .clear
        blurEffect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
