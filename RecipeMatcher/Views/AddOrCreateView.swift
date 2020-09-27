//  AddOrCreateView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 6/27/20.
//  Copyright © 2020 Eric W. All rights reserved.
import UIKit

class AddOrCreateView: UIView {
    
    //MARK: - Properties

    lazy var addCreateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add to One of Your Collections"
        label.font = .boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    lazy var createCollection: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.5486943493)
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let addToCollection = UIImage(systemName: "folder.fill.badge.plus", withConfiguration: config)
        button.setImage(addToCollection, for: .normal)
       
        var newFrame = button.frame.size
        newFrame.width = 40
        newFrame.height = 40
        button.frame.size = newFrame
        return button
    }()
    
    lazy var newCollectionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 0.5040667808)
        textField.placeholder = "CREATE A NEW COLLECTION"
        return textField
    }()
    
    lazy var collectionsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 120, height: 140)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(AddCreateCell.self, forCellWithReuseIdentifier: "addCell")
        return collection
    }()
    
    lazy var collectionStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addCreateTitleLabel])
        stack.axis = .horizontal
        stack.spacing = 50
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var stackBackgroundView:  UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7057714462, green: 0.5156850815, blue: 0.4401528835, alpha: 0.8453820633)
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var objectsViewArray = [self.stackBackgroundView, self.collectionStackView, self.newCollectionTextField, self.createCollection, self.collectionsCV]
    
    //MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addOrCreateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constraints
    private func addOrCreateConstraints() {
        addViewsToSubView()
        newCollectionTextFieldConstraints()
        newCollectionButtonConstraints()
        constrainCollectionsCV()
        constrainStackBackgroundView()
        constrainStackView()
    }
    
    private func constrainStackView(){
        NSLayoutConstraint.activate([
            collectionStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            collectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionStackView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func constrainStackBackgroundView(){
        insertSubview(collectionStackView, aboveSubview: stackBackgroundView)
        NSLayoutConstraint.activate([
            stackBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackBackgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackBackgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            stackBackgroundView.heightAnchor.constraint(equalToConstant: 72)])
    }
    
    private func constrainCollectionsCV() {
        NSLayoutConstraint.activate([
            collectionsCV.topAnchor.constraint(equalTo: stackBackgroundView.bottomAnchor, constant: 8),
            collectionsCV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionsCV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionsCV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -104)])
    }
    
    private func newCollectionTextFieldConstraints() {
        NSLayoutConstraint.activate([
            
            newCollectionTextField.topAnchor.constraint(equalTo: collectionsCV.bottomAnchor, constant: 8),
            newCollectionTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            newCollectionTextField.widthAnchor.constraint(equalToConstant: 330),
            newCollectionTextField.heightAnchor.constraint(equalToConstant: 56)])
    }
    
    private func newCollectionButtonConstraints() {
        NSLayoutConstraint.activate([
            createCollection.topAnchor.constraint(equalTo: collectionsCV.bottomAnchor, constant: 8),
            createCollection.centerYAnchor.constraint(equalTo: newCollectionTextField.centerYAnchor),
            createCollection.leadingAnchor.constraint(equalTo: newCollectionTextField.trailingAnchor, constant: 8)])
    }
}
