//  CollectionsCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/16/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

class CollectionsCell: UICollectionViewCell {
    
//    lazy var collectionsImage: UIImageView = {
//        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 396, height: 200))
//        image.image = UIImage(named: "IceCream")
//        image.contentMode = .scaleAspectFill
//        image.clipsToBounds = true
//        image.layer.allowsGroupOpacity = true
//        image.layer.cornerRadius = 10
//        image.backgroundColor = .clear
//        return image
//    }()
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
    
//    var addButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        let config = UIImage.SymbolConfiguration(pointSize: 40)
//        let addToCollection = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
//        button.setImage(addToCollection, for: .normal)
//        return button
//    }()
    
    func setImageConstraints() {
        contentView.addSubview(collectionsImage)
        collectionsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    func setNameConstraints() {
        contentView.addSubview(recipeTypeLabel)
        recipeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeTypeLabel.topAnchor.constraint(equalTo: collectionsImage.bottomAnchor, constant: 2),
            recipeTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeTypeLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
//    func setAddButtonConstraints() {
//        collectionsImage.addSubview(addButton)
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            addButton.centerYAnchor.constraint(equalTo: collectionsImage.centerYAnchor),
//            addButton.centerXAnchor.constraint(equalTo: collectionsImage.centerXAnchor),
//            addButton.heightAnchor.constraint(equalToConstant: addButton.frame.height),
//            addButton.widthAnchor.constraint(equalToConstant: addButton.frame.width)])
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageConstraints()
        setNameConstraints()
//        setAddButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
