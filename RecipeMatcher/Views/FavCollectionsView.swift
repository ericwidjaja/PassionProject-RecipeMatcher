//  FavCollectionsView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/22/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Kingfisher

class FavCollectionsView: UIView {
    
//MARK: - Objects
//    lazy var backgroundImageView: UIImageView = {
//        let mainImage = UIImageView()
//        mainImage.image = #imageLiteral(resourceName: "MainScreen")
//        mainImage.contentMode = .scaleAspectFill
//        mainImage.clipsToBounds = true
//        return mainImage
//    }()
    
    lazy var myCollectionsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 100)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .gray
        cv.register(CollectionsCell.self, forCellWithReuseIdentifier: "myCell")
        cv.showsHorizontalScrollIndicator = false
        return cv
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
            setMyFavCollectionsUI()
        }
    
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

//MARK: - FavCollectionsView Constraints
    
    private func setMyFavCollectionsUI() {
        self.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 0.8967786815)
        myFavCollTitleLabelConstraints()
        myCollectionsCVConstraints()
    }
    
    private func myFavCollTitleLabelConstraints() {
        addSubview(favCollectionsTitleLabel)
        favCollectionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favCollectionsTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            favCollectionsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            favCollectionsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            favCollectionsTitleLabel.heightAnchor.constraint(equalToConstant: 35)])
    }
    
    private func myCollectionsCVConstraints() {
        addSubview(myCollectionsCV)
        myCollectionsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionsCV.topAnchor.constraint(equalTo: favCollectionsTitleLabel.bottomAnchor, constant: 2),
            myCollectionsCV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myCollectionsCV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myCollectionsCV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
        }
}
