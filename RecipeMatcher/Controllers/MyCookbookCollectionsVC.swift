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
                //                dump(self.myCookbookCollections)
            }
        }
    }
    
    //MARK: - Functions
    private func setMyCkbkCollDelegatesAndCell() {
        cookbookCV.myCollectionsCV.register(CollectionsCell.self, forCellWithReuseIdentifier: "myCell")
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
    
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        view.addSubview(cookbookCV)
        setMyCkbkCollDelegatesAndCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        print("viewWillAppearCalled - hide the navigation bar")
        loadMyCookbkCollections()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
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
        cell.reloadData()
        let collection = myCookbookCollections[indexPath.row]
        cell.recipes = collection.recipes
        cell.recipeTypeLabel.text = collection.recipeType
        cell.delegate = self
        guard let imageUrl = collection.recipes.randomElement()?.image else {
            return cell
        }
        cell.collectionsImage.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
}

extension MyCookbookCollectionsVC: ReloadViewDelegate {
    func reloadCollectionView() {
        loadMyCookbkCollections()
    }
}

extension MyCookbookCollectionsVC: CollectionsCellDelegate {
    func didSelectRecipe(_ recipe: RecipeWrapper) {
        let detailVC = RecipeDetailVC()
        detailVC.recipe = recipe
        self.navigationController?.present(detailVC, animated: true)
    }
}
