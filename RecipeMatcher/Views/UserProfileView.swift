//  UserProfileView.swift
//  RecipeMatcher

import UIKit
import Firebase
import FirebaseAuth


class UserProfileView: UIView {
    
    //MARK: - Objects
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.alpha = 0.4
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "person.circle")
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
    
    lazy var objectsViewArray = [self.containerView, self.userImageView, self.userNameLabel, self.emailLabel]
    
    
    //MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: - Constraints
    private func userProfileConstraints() {
        addViewsToSubView()
//        backGroundImageConstraints()
        //        userImageConstraints()
        userNameConstraints()
        //        userEmailConstraints()
    }
    
    private func backGroundImageConstraints() {
        NSLayoutConstraint.activate([backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    //    private func userImageConstraints() {
    //        NSLayoutConstraint.activate([]])
    //
    //
    //    }
    
    private func userNameConstraints() {
        NSLayoutConstraint.activate([userNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                                     userNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)])
    }
    
    //    private func userEmailConstraints() {
    //        NSLayoutConstraint.activate(<#T##constraints: [NSLayoutConstraint]##[NSLayoutConstraint]#>)
    //
    //    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        userProfileConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
