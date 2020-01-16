//  FavRecipesView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/25/19.

import UIKit

class FavRecipesView: UIView {
    lazy var favoriteList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let cellTable = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cellTable.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
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
            
            favoriteList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            favoriteList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            favoriteList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
