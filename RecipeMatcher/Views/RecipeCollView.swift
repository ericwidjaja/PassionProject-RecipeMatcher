//  RecipeCollView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit
import Foundation

class RecipeCollView: UIView {
    lazy var recipeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 390, height: 280)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 50, right: 1)
        let cellTable = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellTable.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cellTable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setConstraints()
    }
    
    private func setConstraints() {
        addSubview(recipeCollectionView)
        recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            recipeCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            recipeCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            recipeCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            recipeCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
