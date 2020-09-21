//  CookbookCollectionsView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/22/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Kingfisher

class CookbookCollectionsView: UIView {
    
    //MARK: - Objects
    lazy var myCollectionsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 410, height: 180)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var myCollectionLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cookbook Collections"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setMyFavCollectionsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setMyFavCollectionsConstraints()
    }
    
    //MARK: - FavCollectionsView Constraints
    private func setMyFavCollectionsConstraints() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        myFavCollTitleLabelConstraints()
        myCollectionsCVConstraints()
    }
    
    private func myFavCollTitleLabelConstraints() {
        addSubview(myCollectionLabel)
        myCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            myCollectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            myCollectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            myCollectionLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func myCollectionsCVConstraints() {
        addSubview(myCollectionsCV)
        myCollectionsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionsCV.topAnchor.constraint(equalTo: myCollectionLabel.bottomAnchor),
            myCollectionsCV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myCollectionsCV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myCollectionsCV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
