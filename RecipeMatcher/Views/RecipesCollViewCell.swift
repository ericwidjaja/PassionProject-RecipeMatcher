//  RecipesCollViewCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit

class RecipesCollViewCell: UICollectionViewCell {
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    lazy var descriptionContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.95
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Source Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "emptyHeart"), for: .normal)
        button.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        setupDescriptionContainer()
        setupDescriptionViewContent()
    }
    
    private func setupDescriptionContainer() {
        addSubview(descriptionContainer)
        descriptionContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            descriptionContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            descriptionContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
        ])
    }
    
    private func setupDescriptionViewContent() {
        addSubview(recipeLabel)
        addSubview(sourceLabel)
        addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -8),
            favoriteButton.centerYAnchor.constraint(equalTo: descriptionContainer.centerYAnchor, constant: 0),
            favoriteButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionContainer.topAnchor),
            favoriteButton.bottomAnchor.constraint(lessThanOrEqualTo: descriptionContainer.bottomAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            
            recipeLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 8),
            recipeLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 8),
            recipeLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -20),
            
            sourceLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor , constant: 4),
            sourceLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 8),
            sourceLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -8),
        ])
        
    }
    
    private func setConstraints() {
        addSubview(recipeImage)
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            recipeImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            recipeImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            recipeImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}
