//  AddOrCreateVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 6/27/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

class AddOrCreateVC: UIViewController {
    
    //MARK: - Properties
    var addOrCreateView = AddOrCreateView()
    var addOrCreateCollection: RecipeWrapper!
    
    //MARK: - Functions
    func blurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "SplashScreen")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addOrCreateView)
        view.backgroundColor = .clear
        blurEffect()
    }
}
