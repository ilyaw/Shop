//
//  HomeTitleHeaderVie.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import UIKit

class HomeTitleHeaderView: UICollectionReusableView {
    static let categoryHeaderId = "HomeTitleHeaderId"
    static let reuseId = "HomeTitleHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
