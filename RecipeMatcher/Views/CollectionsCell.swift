//  CollectionsCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/16/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

protocol CollectionsCellDelegate: class {
    func didSelectRecipe(_ recipe: RecipeWrapper)
}

class CollectionsCell: UICollectionViewCell {
    
    //MARK: - Properties
    lazy var horizontalCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let horizontalCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalCV.layer.cornerRadius = 15
        horizontalCV.backgroundColor = #colorLiteral(red: 1, green: 0.3748272657, blue: 0, alpha: 0.7335455908)
        horizontalCV.dataSource = self
        horizontalCV.delegate = self
        horizontalCV.register(CkbkCVCell.self, forCellWithReuseIdentifier: "cellID")
        return horizontalCV
    }()
    
    lazy var collectionsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "IceCream")
        image.layer.cornerRadius = 20
        return image
    }()
    
    lazy var recipeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Rockwell", size: 22)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
 
    var recipes: [RecipeWrapper]! {
        didSet {
            //            print(recipes)
        }
    }
    
    weak var delegate: CollectionsCellDelegate?
    
    func reloadData() {
        DispatchQueue.main.async {
            self.horizontalCollView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCVConstraints()
        setRecipeTypeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extensions
extension CollectionsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CkbkCVCell else {//casting it so you can access your properties
            return UICollectionViewCell()}
        
        let specificRecipe = recipes[indexPath.row]
        let imgURL = URL(string: specificRecipe.image)
        cell.ckbkImage.kf.setImage(with: imgURL)
        return cell
    }
}

extension CollectionsCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRecipeFromCollection = recipes[indexPath.row]
        delegate?.didSelectRecipe(selectedRecipeFromCollection)
    }
}

extension CollectionsCell {
    
    // MARK: Constraints
    func setCVConstraints() {
        contentView.addSubview(horizontalCollView)
        horizontalCollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalCollView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            horizontalCollView.heightAnchor.constraint(equalToConstant: 130),
            horizontalCollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalCollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    func setRecipeTypeLabel() {
        contentView.addSubview(recipeTypeLabel)
        recipeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeTypeLabel.topAnchor.constraint(equalTo: horizontalCollView.bottomAnchor, constant: 8),
            recipeTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            recipeTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeTypeLabel.heightAnchor.constraint(equalToConstant: 26)])
    }
}
