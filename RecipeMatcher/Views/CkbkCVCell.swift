//  CkbkCVCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 9/3/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Kingfisher

class CkbkCVCell: UICollectionViewCell {
    
    lazy var ckbkImage: UIImageView = {
        let ckbkImg = UIImageView()
        ckbkImg.layer.cornerRadius = 20
        return ckbkImg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ckbkImgConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CkbkCVCell {
    func ckbkImgConstraints() {
        contentView.addSubview(ckbkImage)
        ckbkImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ckbkImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 8),
            ckbkImage.widthAnchor.constraint(equalTo: contentView.widthAnchor)])
    }
}
