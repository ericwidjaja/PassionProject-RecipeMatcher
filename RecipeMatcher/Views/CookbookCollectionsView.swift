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
        layout.itemSize = CGSize(width: 400, height: 210)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var myCollectionLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cookbook Collections"
        label.font = .boldSystemFont(ofSize: 30)
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
        self.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 0.8967786815)
        myFavCollTitleLabelConstraints()
        myCollectionsCVConstraints()
    }
    
    private func myFavCollTitleLabelConstraints() {
        addSubview(myCollectionLabel)
        myCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            myCollectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myCollectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            myCollectionLabel.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func myCollectionsCVConstraints() {
        addSubview(myCollectionsCV)
        myCollectionsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionsCV.topAnchor.constraint(equalTo: myCollectionLabel.bottomAnchor, constant: 10),
            myCollectionsCV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myCollectionsCV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myCollectionsCV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}