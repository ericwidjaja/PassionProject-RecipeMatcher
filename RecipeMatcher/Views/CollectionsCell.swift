//  CollectionsCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/16/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

class CollectionsCell: UICollectionViewCell {
    
    //MARK: - Properties
    lazy var collView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cvHorizontal = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvHorizontal.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        cvHorizontal.dataSource = self
        cvHorizontal.delegate = self
        cvHorizontal.register(CkbkCVCell.self, forCellWithReuseIdentifier: "cellID")
        return cvHorizontal
    }()
    
    lazy var collectionsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "IceCream")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .clear
        return image
    }()
    
    lazy var recipeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Rockwell", size: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var recipes: [RecipeWrapper]! {
        didSet {
            //            print(recipes)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCVConstraints()
        setNameConstraints()
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
        cell.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        let imgURL = URL(string: specificRecipe.image)
        cell.ckbkImage.kf.setImage(with: imgURL)
        return cell
    }
}

extension CollectionsCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 190)
    }
}


extension CollectionsCell {
    // MARK: Constraints
    func setCVConstraints() {
        contentView.addSubview(collView)
        collView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collView.heightAnchor.constraint(equalToConstant: 200),
            collView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    func setNameConstraints() {
        contentView.addSubview(recipeTypeLabel)
        recipeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeTypeLabel.topAnchor.constraint(equalTo: collView.bottomAnchor, constant: 2),
            recipeTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeTypeLabel.heightAnchor.constraint(equalToConstant: 24)])
    }
}
