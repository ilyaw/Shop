//
//  ArticlesViewCell.swift
//  Shop
//
//  Created by Ilya on 21.01.2022.
//

import UIKit
import Kingfisher

class ArticlesViewCell: UICollectionViewCell {
    static let reuseId = "ArticlesViewCell"
    
    // MARK: - Private properties
    private let articlesImageView = UIImageView()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        articlesImageView.frame = bounds
    }

    override func prepareForReuse() {
        articlesImageView.image = nil
    }
    
    // MARK: - Public methods
    
    func setupCell(with url: URL) {
        articlesImageView.kf.setImage(with: url)
    }
}

// MARK: ArticlesViewCell + private extension

private extension ArticlesViewCell {
    func setupUI() {
        addSubview(articlesImageView)
        layer.cornerRadius = 25
        
        if UIDevice.current.name == "iPod touch (7th generation)" {
            articlesImageView.contentMode = .scaleAspectFit
        } else {
            articlesImageView.contentMode = .scaleAspectFill
        }
    }
}
