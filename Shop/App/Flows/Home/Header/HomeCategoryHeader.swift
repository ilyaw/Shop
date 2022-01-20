//
//  HomeCategoryHeader.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import UIKit

class HomeCategoryHeader: UICollectionReusableView {
    static let categoryHeaderId = "categoryHeaderId"
    static let reuseId = "HomeCategoryHeader"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Категории"
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
