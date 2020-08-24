//
//  FavCollectionsVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 8/22/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit

class FavCollectionsVC: UIViewController {
    
    //MARK: - Properties
    var favCollView = FavCollectionsView()
    var myFavCollections = [FaveCollections]() {
        didSet {
            favCollView.myCollectionsCV.reloadData()
        }
    }
    
    //MARK: - Functions
    
    private func setFavCollDelegates() {
        favCollView.myCollectionsCV.dataSource = self
        favCollView.myCollectionsCV.delegate = self
    }
    
    private func loadMyCollections() {
        do {
            let persistedCollections = try CollectionPersistence.manager.getRecipe()
            myFavCollections = persistedCollections
        } catch {
            print(error)
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favCollView)
        setFavCollDelegates()
//        favCollView.myCollectionsCV.register(CollectionsCell.self, forCellWithReuseIdentifier: "myCell")
        loadMyCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMyCollections()
    }
}

//MARK: - Extension
extension FavCollectionsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFavCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? CollectionsCell else {
            return UICollectionViewCell()
        }
        let collection = myFavCollections[indexPath.row]
        cell.nameLabel.text = collection.recipeType
        cell.addButton.isHidden = true
        return cell
    }
}

extension FavCollectionsVC: Reload {
    func reloadCollectionView() {
        loadMyCollections()
    }
}
