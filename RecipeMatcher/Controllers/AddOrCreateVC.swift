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
    var collections = [CookbookCollections]() {
        didSet {
            self.addOrCreateView.collectionsCV.reloadData()
            dump(collections)
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
    
    private func saveNewCollection(newCollection: CookbookCollections) {
        do {
            try CollectionPersistence.manager
                .save(newElement: newCollection)
            self.addOrCreateView.window?.rootViewController?.dismiss(animated: true, completion: nil)
            delegate?.reloadCollectionView()
        } catch {
            print(error)
        }
    }

    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func buttonsTapped() {
        addOrCreateView.addToCollectionButton.addTarget(self, action: #selector(createButtonPressed(_:)), for: .touchUpInside)
    }
    
    //    MARK: - OBJC Functions
    @objc func createButtonPressed(_ sender: UIButton) {
        guard let collectionName = self.addOrCreateView.newCollectionTextField.text, collectionName != ""
            else {
                self.showAlert(title: "Required", message: "Enter a name for new collection")
                return
        }
        
        let currentCollections = collections
        if currentCollections.contains(where: {$0.recipeType.lowercased() == collectionName.lowercased()}) {
            self.showAlert(title: nil, message: "This collection already exists \n Please create another collection")
        } else {
            if let recipe = recipeCollection {
                let newCollection = CookbookCollections(recipeType: collectionName, recipes: [recipe])
                saveNewCollection(newCollection: newCollection)
            } else {
                let newCollection = CookbookCollections(recipeType: collectionName, recipes: [])
                saveNewCollection(newCollection: newCollection)
            }
        }
    }
    
    private func setDelegates() {
        self.addOrCreateView.collectionsCV.delegate = self
        self.addOrCreateView.collectionsCV.dataSource = self
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addOrCreateView)
        view.backgroundColor = .clear
        blurEffect()
        loadCollections()
        setDelegates()
        buttonsTapped()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addOrCreateView.collectionsCV.reloadData()
    }
}

//MARK: - Extension
extension AddOrCreateVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as? AddCreateCell else {
            return UICollectionViewCell()
        }
        let collection = collections[indexPath.row]
        cell.nameLabel.text = collection.recipeType
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
