//  SearchView.swift
//  RecipeMatcher

import UIKit

class SearchView: UIView {

//MARK: - Objects
    lazy var backgroundImageView: UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = #imageLiteral(resourceName: "Fridge")
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        return mainImage
    }()
    
    lazy var ingredientTextField: UITextField = {
        let ingredientTxtField = UITextField()
        ingredientTxtField.placeholder = "type your ingredient and press enter"
        ingredientTxtField.font = UIFont(name: "Noteworthy", size: 18)
        ingredientTxtField.borderStyle = .roundedRect
        ingredientTxtField.textAlignment = .center
        ingredientTxtField.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ingredientTxtField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ingredientTxtField.autocorrectionType = .yes
        return ingredientTxtField
        
    }()
    
    lazy var ingredientsTblView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "IngredientCell")
        return tableView
    }()
    
    lazy var findRecipesButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.layer.cornerRadius = 12
        button.setTitle("Find Recipes", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 22)
        
        return button
    }()
    
    lazy var objectsViewArray = [self.backgroundImageView, self.ingredientTextField, self.ingredientsTblView, self.findRecipesButton]
    
    
//MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
//MARK: - Constraints
    private func searchViewConstraints() {
        addViewsToSubView()
        backGroundImageConstraints()
        ingredientConstraints()
        tableViewConstraints()
        findRecipesConstraints()
    }
    
    private func backGroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    private func ingredientConstraints() {
        NSLayoutConstraint.activate([
            ingredientTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            ingredientTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            ingredientTextField.heightAnchor.constraint(equalToConstant: 50),
            ingredientTextField.widthAnchor.constraint(equalToConstant: 350)])
    }
    private func tableViewConstraints() {
        NSLayoutConstraint.activate([
            ingredientsTblView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            ingredientsTblView.topAnchor.constraint(equalTo: ingredientTextField.bottomAnchor, constant: 150),
            ingredientsTblView.heightAnchor.constraint(equalToConstant: 325),
            ingredientsTblView.widthAnchor.constraint(equalToConstant: 225)])
    }
    private func findRecipesConstraints() {
        NSLayoutConstraint.activate([
            findRecipesButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 100),
            findRecipesButton.topAnchor.constraint(equalTo: ingredientsTblView.bottomAnchor, constant: 120),
            findRecipesButton.heightAnchor.constraint(equalToConstant: 40),
            findRecipesButton.widthAnchor.constraint(equalToConstant: 150)])
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        searchViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
