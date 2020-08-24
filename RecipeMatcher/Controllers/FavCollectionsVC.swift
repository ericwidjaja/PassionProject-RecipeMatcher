//
//  FavCollectionsVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 8/22/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit

class FavCollectionsVC: UIViewController {
    
    //MARK: - Properties
    var favCollView = FavCollectionsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favCollView)
        view.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    }
}
