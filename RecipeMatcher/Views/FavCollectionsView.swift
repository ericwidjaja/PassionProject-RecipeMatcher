//
//  FavCollectionsView.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 8/22/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit
import Kingfisher

class FavCollectionsView: UIView {
    
//MARK: - Objects
    lazy var backgroundImageView: UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = #imageLiteral(resourceName: "MainScreen")
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        return mainImage
    }()
    
    lazy var favCollectionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Collections"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    

//MARK: - Constraints

    
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            favCollViewConstraints()
        }
    
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
        }

    //MARK: - FavCollectionsView Constraints
    private func constraintsFavCollectionsTitleLabel(){
        addSubview(favCollectionsTitleLabel)
        favCollectionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favCollectionsTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            favCollectionsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favCollectionsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionsTitleLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func favCollViewConstraints(){
        constraintsFavCollectionsTitleLabel()
    }
}
