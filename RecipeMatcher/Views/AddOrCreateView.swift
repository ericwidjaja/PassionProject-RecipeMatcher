//  AddOrCreateView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 6/27/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit

class AddOrCreateView: UIView {
    
    //MARK: - Properties
    lazy var createCollTitleButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let createCollectionFolder = UIImage(systemName: "folder.fill.badge.plus", withConfiguration: config)
        button.setImage(createCollectionFolder, for: .normal)
        var newFrame = button.frame.size
        newFrame.width = 40
        newFrame.height = 40
        button.frame.size = newFrame
        return button
    }()
    
    var addToCollectionButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let addToCollection = UIImage(systemName: "folder.fill.badge.plus", withConfiguration: config)
        button.setImage(addToCollection, for: .normal)
        //bookmark.fill?
        var newFrame = button.frame.size
        newFrame.width = 40
        newFrame.height = 40
        button.frame.size = newFrame
        return button
    }()
    
    var newCollectionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        textField.placeholder = "Enter new collection name"
        return textField
    }()
    
    var collectionsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 130)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(AddCreateCell.self, forCellWithReuseIdentifier: "addCell")
        return collection
    }()
    
    lazy var collectionStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [addToCollectionButton, createCollectionButton])
        let stack = UIStackView(arrangedSubviews: [addToCollectionButton])
        stack.axis = .horizontal
        stack.spacing = 50
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var stackBackgroundView:  UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7057714462, green: 0.5156850815, blue: 0.4401528835, alpha: 0.5958101455)
        view.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        return view
    }()
    
    lazy var objectsViewArray = [self.newCollectionTextField, self.collectionsCV, self.stackBackgroundView, self.collectionStackView]
    
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
        constrainCollectionsCV()
        constrainStackBackgroundView()
        constrainStackView()
    }
    
    private func constrainStackView(){
        NSLayoutConstraint.activate([
            collectionStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainStackBackgroundView(){
        insertSubview(collectionStackView, aboveSubview: stackBackgroundView)
        NSLayoutConstraint.activate([
            stackBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackBackgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackBackgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            stackBackgroundView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func newCollectionTextFieldConstraints() {
        NSLayoutConstraint.activate([
            newCollectionTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            newCollectionTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newCollectionTextField.topAnchor.constraint(equalTo: addToCollectionButton.bottomAnchor, constant: 50),
            newCollectionTextField.heightAnchor.constraint(equalToConstant: 60)])
    }
    
    private func constrainCollectionsCV() {
        NSLayoutConstraint.activate([
            collectionsCV.topAnchor.constraint(equalTo: newCollectionTextField.bottomAnchor, constant: 20),
            collectionsCV.leadingAnchor.constraint(equalTo: newCollectionTextField.leadingAnchor),
            collectionsCV.trailingAnchor.constraint(equalTo: newCollectionTextField.trailingAnchor),
            collectionsCV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
