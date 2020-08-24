//  FavdRecipesCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/16/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

class FavdRecipesCell: UICollectionViewCell {
    
    lazy var favdRecipeImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    lazy var favdRecipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Label"
        label.font = UIFont.init(name: "Rockwell", size: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var objectsViewArray = [self.favdRecipeLabel, self.favdRecipeImage]
    
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
        favCollViewConstraints()
    }
    
    func favCollViewConstraints() {
        NSLayoutConstraint.activate([
        favdRecipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        favdRecipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        favdRecipeImage.widthAnchor.constraint(equalToConstant: favdRecipeImage.frame.width),
        favdRecipeImage.heightAnchor.constraint(equalToConstant: favdRecipeImage.frame.height),
        
        favdRecipeLabel.topAnchor.constraint(equalTo: favdRecipeImage.bottomAnchor),
        favdRecipeLabel.leadingAnchor.constraint(equalTo: favdRecipeImage.leadingAnchor),
        favdRecipeLabel.trailingAnchor.constraint(equalTo: favdRecipeImage.trailingAnchor),
        favdRecipeLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
}
