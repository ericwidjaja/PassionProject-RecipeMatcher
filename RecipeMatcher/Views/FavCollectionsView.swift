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
    
    lazy var favCollectionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Collections"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()
    
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            constraintsFavCollectionsTitleLabel()
        }
    
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            constraintsFavCollectionsTitleLabel()
        }

    //MARK: - FavCollectionsView Constraints
    private func constraintsFavCollectionsTitleLabel(){
        addSubview(favCollectionsTitleLabel)
        favCollectionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favCollectionsTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
            favCollectionsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favCollectionsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionsTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
