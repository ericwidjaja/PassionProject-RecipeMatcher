//  CkbkCVCell.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 9/3/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Kingfisher

class CkbkCVCell: UICollectionViewCell {
    
    lazy var ckbkImage: UIImageView = {
        let ckbkImg = UIImageView()
        ckbkImg.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
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
            ckbkImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 10),
            ckbkImage.widthAnchor.constraint(equalTo: contentView.widthAnchor)])
    }
}
