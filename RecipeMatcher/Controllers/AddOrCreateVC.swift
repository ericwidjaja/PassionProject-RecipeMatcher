//  AddOrCreateVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 6/27/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

class AddOrCreateVC: UIViewController {
    
    //MARK: - Properties
    var addOrCreateView = AddOrCreateView()
    var recipeCollection: RecipeWrapper!
    var delegate: Reload?
    var collections = [FaveCollections]() {
        didSet {
            self.addOrCreateView.collectionsCV.reloadData()
        }
    }
    
    //MARK: - Functions
    func blurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "SplashScreen")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func loadCollections() {
        do {
            let persistedCollections = try CollectionPersistence.manager.getRecipe()
            collections = persistedCollections
        } catch {
            print(error)
        }
    }
    
    private func saveNewCollection(newCollection: FaveCollections) {
        do {
            try CollectionPersistence.manager
            .save(newElement: newCollection)
            self.addOrCreateView.window?.rootViewController?.dismiss(animated: true, completion: nil)
            delegate?.reloadCollectionView()
        } catch {
            print(error)
        }
    }
    
    //MARK: - OBJC Functions
    //    @objc func createButtonPressed() {
    //        guard let collectionName = newCollectionTextField.text, collectionName != "" else {
    //            print("please create name for your collection")
    //            return
    //        }
    //        if let
    //    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addOrCreateView)
        view.backgroundColor = .clear
        blurEffect()
    }
}
//MARK: - Extension
extension AddOrCreateVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as? CollectionsCell else {
            return UICollectionViewCell()
        }
        let collection = collections[indexPath.row]
        cell.nameLabel.text = collection.recipeTitle
        cell.addButton.isHidden = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        do {
            guard let recipe = recipeCollection else {
                return }
            var collection = collections[indexPath.row]
            collection.recipes.append(recipe)
            try CollectionPersistence.manager.replace(newArr: collections)
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
}
