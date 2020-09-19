//  UserProfileView.swift
//  RecipeMatcher

import UIKit
import Firebase
import FirebaseAuth


class UserProfileView: UIView {
    
    //MARK: - Objects
    
    //    lazy var contentView: UIView = {
    //        let profileView = UIView()
    //        profileView.backgroundColor = #colorLiteral(red: 0.1504360437, green: 0.006763501558, blue: 0.5917420983, alpha: 0.7002622003)
    //        profileView.alpha = 0.4
    //        return profileView
    //    }()
    //
    lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = #imageLiteral(resourceName: "MainScreen")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        return backgroundImage
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
    
    lazy var objectsViewArray = [self.userImageView, self.userNameLabel, self.emailLabel]
    
    
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
