//  RecipesCollViewCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit

class RecipesCollViewCell: UICollectionViewCell {
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var addtDescView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.75
        return view
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Label"
        label.font = UIFont.init(name: "Rockwell", size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Source Label"
        label.font = UIFont.init(name: "Rockwell", size: 14)
        label.textColor = .darkGray
        return label
    }()
    
    var faveButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 27, weight: .heavy, scale: .small)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        button.setBackgroundImage(heart, for: .normal)
        button.imageView!.contentMode = UIView.ContentMode.center
        button.backgroundColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0.2004762414)
        button.tintColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        return button
    }()
    
    lazy var objectsViewArray = [self.addtDescView, self.recipeLabel, self.sourceLabel, self.faveButton, self.recipeImage]
        
    //MARK: - Add ViewsToSubviews
        func addViewsToSubView() {
            for aView in objectsViewArray {
                self.addSubview(aView)
                aView.translatesAutoresizingMaskIntoConstraints = false
            }
        }

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setConstraints()
    }
    
    private func setConstraints() {
        addViewsToSubView()
        collViewConstraints()
        addtDescConstraints()
        descriptionViewConstraints()
    }
    
    private func addtDescConstraints() {
        addSubview(addtDescView)
        NSLayoutConstraint.activate([
            addtDescView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            addtDescView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            addtDescView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    private func descriptionViewConstraints() {
        addSubview(recipeLabel)
        addSubview(sourceLabel)
        addSubview(faveButton)
        
        NSLayoutConstraint.activate([
            faveButton.trailingAnchor.constraint(equalTo: addtDescView.trailingAnchor),
            faveButton.centerYAnchor.constraint(equalTo: addtDescView.centerYAnchor),
            faveButton.topAnchor.constraint(equalTo: addtDescView.topAnchor),
            faveButton.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor),
            
            recipeLabel.topAnchor.constraint(equalTo: addtDescView.topAnchor, constant: 8),
            recipeLabel.leadingAnchor.constraint(equalTo: addtDescView.leadingAnchor, constant: 8),
            recipeLabel.heightAnchor.constraint(equalToConstant: 22),
            recipeLabel.trailingAnchor.constraint(equalTo: addtDescView.trailingAnchor, constant: -35),
            
            sourceLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor , constant: 4),
            sourceLabel.leadingAnchor.constraint(equalTo: addtDescView.leadingAnchor, constant: 8),
            sourceLabel.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor, constant: -4)])
    }
    
    private func collViewConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
