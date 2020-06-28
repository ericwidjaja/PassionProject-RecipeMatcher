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
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: UIImage.SymbolWeight.medium)
        let createCollectionFolder = UIImage(systemName: "folder.fill.badge.plus", withConfiguration: config)
        button.setImage(createCollectionFolder, for: .normal)
        var newFrame = button.frame.size
        newFrame.width = 35
        newFrame.height = 35
        button.frame.size = newFrame
        return button
    }()
    
    var addToCollectionButton: UIButton = {
        let button = UIButton()
        button.tintColor = .green
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: UIImage.SymbolWeight.medium)
        let addToCollection = UIImage(systemName: "plus", withConfiguration: config)
        button.setImage(addToCollection, for: .normal)
        //bookmark.fill?
        var newFrame = button.frame.size
        newFrame.width = 35
        newFrame.height = 35
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
        let alert = UIAlertController(title: "Required", message: "Enter a name for new collection", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}
