//  CollectionsCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/16/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

class CollectionsCell: UICollectionViewCell {
    
    lazy var collectionsImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 396, height: 200))
//        let image = UIImageView()
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
        label.textColor = .black
        label.backgroundColor = .gray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        let addToCollection = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
        button.setImage(addToCollection, for: .normal)
        return button
    }()
    
    func setImageConstraints() {
        contentView.addSubview(collectionsImage)
        collectionsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    func setNameConstraints() {
        collectionsImage.addSubview(recipeTypeLabel)
        recipeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            recipeTypeLabel.topAnchor.constraint(equalTo: collectionsImage.bottomAnchor, constant: 10),
            recipeTypeLabel.leadingAnchor.constraint(equalTo: collectionsImage.leadingAnchor),
            recipeTypeLabel.trailingAnchor.constraint(equalTo: collectionsImage.trailingAnchor),
            recipeTypeLabel.bottomAnchor.constraint(equalTo: collectionsImage.bottomAnchor, constant: -2)])
    }
    func setAddButtonConstraints() {
        collectionsImage.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: collectionsImage.centerYAnchor),
            addButton.centerXAnchor.constraint(equalTo: collectionsImage.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: addButton.frame.height),
            addButton.widthAnchor.constraint(equalToConstant: addButton.frame.width)])
    }
    
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
