//
//  MyCookbookCollectionsVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/22/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Kingfisher

class MyCookbookCollectionsVC: UIViewController {
    
    //MARK: - Properties
    var cookbookCV = CookbookCollectionsView()
    var cookbkCollCell = CollectionsCell()
    var myCookbookCollections = [CookbookCollection]() {
        didSet {
            DispatchQueue.main.async {
                self.cookbookCV.myCollectionsCV.reloadData()
//                dump(self.myCookbookCollections) // to check if the collections are existed
            }
        }
    }
    
    //MARK: - Functions
    private func setMyCookbookDelegates() {
        cookbookCV.myCollectionsCV.dataSource = self
        cookbookCV.myCollectionsCV.delegate = self
    }
    
    private func loadMyCookbkCollections() {
        do {
            let persistedCollections = try CollectionPersistence.manager.getRecipe()
            myCookbookCollections = persistedCollections
        } catch {
            print(error)
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cookbookCV)
        setMyCookbookDelegates()
        cookbookCV.myCollectionsCV.register(CollectionsCell.self, forCellWithReuseIdentifier: "myCell")
        loadMyCookbkCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMyCookbkCollections()
    }
}

//MARK: - Extensions
extension MyCookbookCollectionsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCookbookCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cookbookCV.myCollectionsCV .dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? CollectionsCell else {
            return UICollectionViewCell()
        }
        let collection = myCookbookCollections[indexPath.row]
        cell.recipeTypeLabel.text = collection.recipeType
        guard let imageUrl = collection.recipes.randomElement()?.image else {
            return cell
        }
        cell.collectionsImage.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
}

extension MyCookbookCollectionsVC: Reload {
    func reloadCollectionView() {
        loadMyCookbkCollections()
    }
}