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
        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 25
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
        label.font = UIFont.init(name: "Rockwell", size: 15)
        label.textColor = .darkGray
        return label
    }()
    
    var cellDelegate: buttonFunction?
    
    lazy var faveButton: UIButton = { [unowned self] in
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium, scale: .medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        button.addTarget(self, action: #selector(favButtonPressed(sender:)), for: .touchUpInside)
        button.setBackgroundImage(heart, for: .normal)
        button.imageView!.contentMode = UIView.ContentMode.center
        button.backgroundColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0.09934182359)
        button.tintColor = #colorLiteral(red: 0.4473546743, green: 0.01570944674, blue: 0.1842742264, alpha: 0.8538634418)
        return button
    }()
    
    @objc private func favButtonPressed(sender: UIButton){
        cellDelegate?.heartButtonPressed(tag: sender.tag)
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium, scale: .medium)
        let heart = UIImage(systemName: "heart.fill", withConfiguration: config)
        faveButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        faveButton.setBackgroundImage(heart, for: .normal)
        faveButton.imageView!.contentMode = UIView.ContentMode.center
        faveButton.tintColor = #colorLiteral(red: 0.4473546743, green: 0.01570944674, blue: 0.1842742264, alpha: 0.8538634418)
        print("Favorited")
    }

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
            addtDescView.heightAnchor.constraint(equalToConstant: 70)
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
            recipeLabel.heightAnchor.constraint(equalToConstant: 21),
            recipeLabel.trailingAnchor.constraint(equalTo: addtDescView.trailingAnchor, constant: -40),
            
            sourceLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor , constant: 2),
            sourceLabel.leadingAnchor.constraint(equalTo: addtDescView.leadingAnchor, constant: 8),
            sourceLabel.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor, constant: 3)])
    }
    
    private func collViewConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
