//
//  AdsBannerViewCell.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import UIKit
import Kingfisher

class AdsBannerViewCell: UICollectionViewCell {
    static let reuseId = "AdsBannerViewCell"
    
    // MARK: - Private properties
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bannerImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bannerImageView.frame = bounds
    }
    
    // MARK: - Public methods
    
    func setupCell(with url: URL) {
        bannerImageView.kf.setImage(with: url)
    }
    
    override func prepareForReuse() {
        bannerImageView.image = nil
    }
}
