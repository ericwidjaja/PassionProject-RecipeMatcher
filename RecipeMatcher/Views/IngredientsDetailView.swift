//  IngredientsDetailView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/16/19.


import UIKit

class DetailView: UIView {


    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFill
//        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Label"
        label.font = UIFont.init(name: "Rockwell-Bold", size: 21)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ingredientsTxtView: UITextView = {
        let txtView = UITextView()
        txtView.font = UIFont.init(name: "Rockwell", size: 17)
        txtView.adjustsFontForContentSizeCategory = true
        txtView.isEditable = false
        txtView.textColor = .darkGray
        txtView.textAlignment = .left
        // Make UITextView web links clickable
        txtView.isSelectable = true
        txtView.dataDetectorTypes = UIDataDetectorTypes.link
        return txtView
    }()
    
    lazy var urlButton: UIButton = {
        let button = UIButton(type: .system)
            button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            button.layer.cornerRadius = 14
            button.setTitle("Cooking Instructions", for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
            button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 16)
            return button
        }()
        
    
    
    lazy var objectsViewArray = [self.recipeImage, self.recipeLabel, self.ingredientsTxtView, self.urlButton]
    
    //MARK: - Add ViewsToSubviews
        func addViewsToSubView() {
            for aView in objectsViewArray {
                self.addSubview(aView)
                aView.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    //MARK: - Constraints
    private func detailViewConstraints() {
        addViewsToSubView()
        detailImageConstraints()
        recipeLabelConstraints()
        ingredientTxtViewConstraints()
        instructionsLinkConstraints()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        detailViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    private func detailImageConstraints() {
        NSLayoutConstraint.activate([
        recipeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        recipeImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        recipeImage.heightAnchor.constraint(equalToConstant: 300),
        recipeImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)])
    }
    
    private func recipeLabelConstraints(){
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo:
                safeAreaLayoutGuide.topAnchor, constant: 340),
            recipeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            recipeLabel.widthAnchor.constraint(equalToConstant: 400)])
    }
    
    private func ingredientTxtViewConstraints(){
        NSLayoutConstraint.activate([
            ingredientsTxtView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 10),
            ingredientsTxtView.heightAnchor.constraint(equalToConstant: 380),
            ingredientsTxtView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            ingredientsTxtView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10)])
    }
    
    private func instructionsLinkConstraints() {
        NSLayoutConstraint.activate([
            urlButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 75),
            urlButton.topAnchor.constraint(equalTo: ingredientsTxtView.bottomAnchor, constant: 15),
            urlButton.heightAnchor.constraint(equalToConstant: 30),
            urlButton.widthAnchor.constraint(equalToConstant: 200)])
    }
}
