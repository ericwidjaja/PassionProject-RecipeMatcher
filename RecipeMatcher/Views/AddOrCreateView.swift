//
//  AddOrCreateView.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 6/27/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit

class AddOrCreateView: UIView {
    
    //MARK: - Properties
    lazy var createCollectionButton: UIButton = {
        let button = UIButton()
        button.tintColor = .green
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
        button.tintColor = .green
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let addToCollection = UIImage(systemName: "plus", withConfiguration: config)
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
    
    lazy var objectsViewArray = [self.createCollectionButton, self.addToCollectionButton, self.newCollectionTextField]
    
    //MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: - Functions
    @objc func createButtonPressed() {
        guard let collectionName = newCollectionTextField.text, collectionName != "" else {
            makeAlert()
            return
        }
    }
    
    private func makeAlert() {
//                let alert = UIAlertController(title: "Required", message: "Enter a name for new collection", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(ok)
//        
//                present(alert, animated: true, completion: nil)
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
        createCollectionButtonConstraints()
        addToCollectionButtonConstraints()
        newCollectionTextFieldConstraints()
        
    }
    private func createCollectionButtonConstraints() {
        NSLayoutConstraint.activate([
            createCollectionButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            createCollectionButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            createCollectionButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            createCollectionButton.heightAnchor.constraint(equalToConstant: 70)])
        }
    
    private func addToCollectionButtonConstraints() {
        NSLayoutConstraint.activate([
            addToCollectionButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            addToCollectionButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addToCollectionButton.topAnchor.constraint(equalTo: createCollectionButton.bottomAnchor, constant: 30),
            addToCollectionButton.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    private func newCollectionTextFieldConstraints() {
        NSLayoutConstraint.activate([
        newCollectionTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        newCollectionTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
        newCollectionTextField.topAnchor.constraint(equalTo: addToCollectionButton.bottomAnchor, constant: 50),
        newCollectionTextField.heightAnchor.constraint(equalToConstant: 70)])
        }
}
