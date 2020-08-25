//  AddCreateCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/24/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

class AddCreateCell: UICollectionViewCell {
    
    lazy var collectionsImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 115))
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Rockwell", size: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        let addToCollection = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
        button.setImage(addToCollection, for: .normal)
        button.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return button
    }()
    
    func setImageConstraints() {
        contentView.addSubview(collectionsImage)
        collectionsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            collectionsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionsImage.widthAnchor.constraint(equalToConstant: collectionsImage.frame.width),
            collectionsImage.heightAnchor.constraint(equalToConstant: collectionsImage.frame.height)])
    }
    func setNameConstraints() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: collectionsImage.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: collectionsImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: collectionsImage.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
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
        setAddButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
