//
//  ProductDetailInfoView.swift
//  Shop
//
//  Created by Ilya on 23.01.2022.
//

import UIKit

class ProductDetailInfoView: UIView {
    
    // MARK: - Private set properties
    
    private(set) var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) var productTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private(set) var productDesciption: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProductDetailInfoView + private extension

private extension ProductDetailInfoView {
    struct Constant {
        static let topIndent: CGFloat = 10
        static let leftIndent: CGFloat = 10
        static let rightIndent: CGFloat = -10
        static let bottomIndent: CGFloat = -10
        
        static let mainPhotoHegiht: CGFloat = 300
    }
    
    func configureUI() {
    
        backgroundColor = .blue
        
        _ = [productImageView, productTitle, productDesciption].map {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setConstraints()
      
        productTitle.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        productTitle.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        productTitle.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        productTitle.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topIndent),
            productImageView.heightAnchor.constraint(equalToConstant: Constant.mainPhotoHegiht),
            productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constant.leftIndent),
            productImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constant.rightIndent),
            
            productTitle.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Constant.topIndent),
            productTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: Constant.leftIndent),
            productTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: Constant.rightIndent),
            
            productDesciption.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: Constant.topIndent),
            productDesciption.leftAnchor.constraint(equalTo: leftAnchor, constant: Constant.leftIndent),
            productDesciption.rightAnchor.constraint(equalTo: rightAnchor, constant: Constant.rightIndent),
            productDesciption.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomIndent)
        ])
    }
}
