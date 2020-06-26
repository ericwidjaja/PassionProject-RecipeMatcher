//  RecipeDetailView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/16/19.


import UIKit

class RecipeDetailView: UIView {
    
    enum HeartStatus {
        case filled
        case notFilled
    }
    
    var heartStatus: HeartStatus = .notFilled
    var cellDelegate: HeartButtonDelegate?
    var delegate: HeartButtonDelegate?
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RecipeImgHolder")
        image.contentMode = .scaleAspectFill
        image.layer.allowsGroupOpacity = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    lazy var addtDescView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.65
        return view
    }()
    
    var shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: UIImage.SymbolWeight.medium)
        let share = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        button.setImage(share, for: .normal)
        //share.fill?
        var newFrame = button.frame.size
        newFrame.width = 35
        newFrame.height = 35
        button.frame.size = newFrame
        return button
    }()
    
    
    var bookmarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: UIImage.SymbolWeight.medium)
        let bookmark = UIImage(systemName: "bookmark", withConfiguration: config)
        button.setImage(bookmark, for: .normal)
        //bookmark.fill?
        var newFrame = button.frame.size
        newFrame.width = 35
        newFrame.height = 35
        button.frame.size = newFrame
        return button
    }()
    
    var heartButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(heart, for: .normal)
        //heart.fill
        var newFrame = button.frame.size
        newFrame.width = 40
        newFrame.height = 40
        button.frame.size = newFrame
        return button
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Label"
        label.textColor = .white
        label.font = UIFont.init(name: "Rockwell-Bold", size: 24)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ingredientsTxtView: UITextView = {
        let txtView = UITextView()
        txtView.font = UIFont.init(name: "Rockwell", size: 18)
        txtView.adjustsFontForContentSizeCategory = true
        txtView.isEditable = false
        txtView.textColor = .darkGray
        txtView.textAlignment = .left
        txtView.isSelectable = true
        txtView.textContainerInset = UIEdgeInsets(top: 25, left: 20, bottom: 25, right: 20)
        return txtView
    }()
    
    lazy var urlButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 14
        button.setTitle("Cooking Instructions", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 18)
        return button
    }()
    
    lazy var objectsViewArray = [self.recipeImage, self.addtDescView, self.shareButton, self.bookmarkButton, self.heartButton,  self.recipeLabel, self.ingredientsTxtView, self.urlButton]
    
    //MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: Function -
    @objc func shareTapped(sender: UIButton) {
        //TODO: Create a share link thru sms, email, instagram or fb
    }
    @objc func heartTapped(sender: UIButton) {
        switch heartStatus {
        case .notFilled:
            makeHeartFill()
            delegate?.saveToPersistance(tag: sender.tag)
        case .filled:
            makeHeartEmpty()
            delegate?.deleteFromPersistance(tag: sender.tag)
        }
    }
    
    func makeHeartFill() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart.fill", withConfiguration: config)
        heartButton.setImage(heart, for: .normal)
        heartStatus = .filled
    }
    
    func makeHeartEmpty() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        heartButton.setImage(heart, for: .normal)
        heartStatus = .notFilled
    }
    @objc func bookmarkTapped(sender: UIButton) {
        //TODO: Create new collection or add to existing collection
    }
    
    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        detailViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constraints
    private func detailViewConstraints() {
        addViewsToSubView()
        detailImageConstraints()
        addtDescConstraints()
        descriptionViewConstraints()
        recipeLabelConstraints()
        ingredientTxtViewConstraints()
        instructionsLinkConstraints()
    }
    
    private func addtDescConstraints() {
        addSubview(addtDescView)
        NSLayoutConstraint.activate([
            addtDescView.bottomAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 50),
            addtDescView.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor),
            addtDescView.leadingAnchor.constraint(equalTo: recipeImage.leadingAnchor),
            addtDescView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func descriptionViewConstraints() {
        shareButton.addTarget(self, action: #selector(shareTapped(sender:)), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped(sender:)), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(heartTapped(sender:)), for: .touchUpInside)
        addSubview(shareButton)
        addSubview(bookmarkButton)
        addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: addtDescView.leadingAnchor, constant: 60),
            shareButton.centerYAnchor.constraint(equalTo: addtDescView.centerYAnchor),
            shareButton.topAnchor.constraint(equalTo: addtDescView.topAnchor),
//            shareButton.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor),
            
            bookmarkButton.centerXAnchor.constraint(equalTo: addtDescView.centerXAnchor) ,
            bookmarkButton.centerYAnchor.constraint(equalTo: addtDescView.centerYAnchor),
            bookmarkButton.topAnchor.constraint(equalTo: addtDescView.topAnchor),
//            bookmarkButton.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor),
            
            heartButton.trailingAnchor.constraint(equalTo: addtDescView.trailingAnchor, constant: -60),
            heartButton.centerYAnchor.constraint(equalTo: addtDescView.centerYAnchor),
            heartButton.topAnchor.constraint(equalTo: addtDescView.topAnchor),
//            heartButton.bottomAnchor.constraint(equalTo: addtDescView.bottomAnchor),
            ])
    }
    
    private func detailImageConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: topAnchor),
            recipeImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: 320),
            recipeImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)])
    }
    
    private func recipeLabelConstraints(){
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 60),
            recipeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            recipeLabel.heightAnchor.constraint(equalToConstant: 50),
            recipeLabel.widthAnchor.constraint(equalToConstant: 400)])
    }
    
    private func ingredientTxtViewConstraints(){
        NSLayoutConstraint.activate([
            ingredientsTxtView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 10),
            ingredientsTxtView.heightAnchor.constraint(equalToConstant: 350),
            ingredientsTxtView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            ingredientsTxtView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -15)])
    }
    
    private func instructionsLinkConstraints() {
        NSLayoutConstraint.activate([
            urlButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 75),
            urlButton.topAnchor.constraint(equalTo: ingredientsTxtView.bottomAnchor, constant: 10),
            urlButton.heightAnchor.constraint(equalToConstant: 30),
            urlButton.widthAnchor.constraint(equalToConstant: 200)])
    }
}
