//  FavRecipesView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/25/19.

import UIKit
import Kingfisher

class FavRecipesView: UIView {
    
    //MARK: - Objects
    lazy var myFavoriteLabel: UILabel = {
        let label = UILabel()
        label.text = "My Favorite Recipes"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    lazy var favoriteCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: -15, right: 2)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.1115208194, green: 0.1115471795, blue: 0.1115173772, alpha: 0.3471211473)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        favRecipesConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        favRecipesConstraints()
    }
    //MARK: - Constraints
    private func favRecipesConstraints() {
        addSubview(favoriteCollView)
        addSubview(myFavoriteLabel)
        myFavoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myFavoriteLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            myFavoriteLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            myFavoriteLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myFavoriteLabel.heightAnchor.constraint(equalToConstant: 36)])
        
        favoriteCollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteCollView.topAnchor.constraint(equalTo: myFavoriteLabel.bottomAnchor, constant: 8),
            favoriteCollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            favoriteCollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteCollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
