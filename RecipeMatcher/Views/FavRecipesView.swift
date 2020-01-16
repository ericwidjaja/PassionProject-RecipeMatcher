//  FavRecipesView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/25/19.

import UIKit

class FavRecipesView: UIView {
    lazy var favoriteList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 250)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let cellTable = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellTable.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return cellTable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        favRecipesConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        favRecipesConstraints()
    }
    
    private func favRecipesConstraints() {
        addSubview(favoriteList)
        favoriteList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            favoriteList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoriteList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            favoriteList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
