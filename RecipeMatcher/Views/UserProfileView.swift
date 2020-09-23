//  UserProfileView.swift
//  RecipeMatcher

import UIKit
import Firebase
import FirebaseAuth


class UserProfileView: UIView {
    
    //MARK: - Objects
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.alpha = 0.225
        view.layer.borderWidth = 6
        view.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "person.circle")
        imageView.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 150/2
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "eric"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        return nameLabel
    }()
    
    lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "e-mail"
        emailLabel.textAlignment = .center
        emailLabel.textColor = UIColor.white
        return emailLabel
    }()
    
    var logOutButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.3748272657, blue: 0, alpha: 0.7335455908)
        button.layer.cornerRadius = 8
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.isUserInteractionEnabled = true
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        return button
    }()
    
    lazy var objectsViewArray = [self.containerView, self.userImageView, self.userNameLabel, self.emailLabel, self.logOutButton]
    
    
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
        userProfileConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constraints
    private func userProfileConstraints() {
        addViewsToSubView()
        logOutConstraints()
        containerViewConstraints()
        itemsContainerConstraints()
    }
    
    private func logOutConstraints() {
        addSubview(logOutButton)
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logOutButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logOutButton.heightAnchor.constraint(equalToConstant: 32),
            logOutButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func containerViewConstraints() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 75),
            containerView.heightAnchor.constraint(equalToConstant: 416), containerView.widthAnchor.constraint(equalToConstant: 300)])
    }
    
    private func itemsContainerConstraints() {
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            
            userImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -110),
            userImageView.widthAnchor.constraint(equalToConstant: 150),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            
            userNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            userNameLabel.heightAnchor.constraint(equalToConstant: 48),
            
            emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 32),
            emailLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 48)])
    }
}
