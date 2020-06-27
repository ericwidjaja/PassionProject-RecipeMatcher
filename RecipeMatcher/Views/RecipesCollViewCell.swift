//  RecipesCollViewCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit

class RecipesCollViewCell: UICollectionViewCell {
    
    enum HeartStatus {
        case filled
        case notFilled
    }
    
    var heartStatus: HeartStatus = .notFilled
    var cellDelegate: HeartButtonDelegate?
    var delegate: HeartButtonDelegate?
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 30
        return image
    }()
    
    lazy var addtDescView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.65
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
    
    var heartButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(heart, for: .normal)
        //heart.fill
        var newFrame = button.frame.size
        newFrame.width = 40
        newFrame.height = 40
        button.frame.size = newFrame
        return button
    }()
    
    lazy var objectsViewArray = [self.addtDescView, self.recipeLabel, self.sourceLabel, self.heartButton, self.recipeImage]
    
    //MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: - Functions
    @objc func heartTapped(sender: UIButton) {
        switch heartStatus {
        case .notFilled:
            makeHeartFill()
            delegate?.saveToPersistance(tag: sender.tag)
        case .filled:
            makeHeartEmpty()
            delegate?.deleteFromPersistance(tag: sender.tag)
        }
    }
    
    func makeHeartFill() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart.fill", withConfiguration: config)
        heartButton.setImage(heart, for: .normal)
        heartStatus = .filled
    }
    
    func makeHeartEmpty() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        heartButton.setImage(heart, for: .normal)
        heartStatus = .notFilled
    }
    
    
    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setConstraints()
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        addViewsToSubView()
        collViewConstraints()
        addtDescConstraints()
        descriptionViewConstraints()
    }
    
    private func addtDescConstraints() {
        addSubview(addtDescView)
        NSLayoutConstraint.activate([
            addtDescView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 5),
            addtDescView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            addtDescView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            addtDescView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func descriptionViewConstraints() {
        heartButton.addTarget(self, action: #selector(heartTapped(sender:)), for: .touchUpInside)
        addSubview(recipeLabel)
        addSubview(sourceLabel)
        addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: addtDescView.trailingAnchor),
            heartButton.centerYAnchor.constraint(equalTo: addtDescView.centerYAnchor),
            heartButton.topAnchor.constraint(equalTo: addtDescView.topAnchor),
            heartButton.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor),
            
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
