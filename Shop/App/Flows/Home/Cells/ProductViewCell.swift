//
//  ProductViewCell.swift
//  Shop
//
//  Created by Ilya on 21.01.2022.
//

import UIKit
import Kingfisher

class ProductViewCell: UICollectionViewCell {
    static let reuseId = "ProductViewCell"
    
    // MARK: - Private properties
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        iconView.image = nil
        productNameLabel.text = nil
        priceLabel.text = nil
        oldPriceLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Public methods
    
    func setupCell(product: ProductViewModel) {
        iconView.kf.setImage(with: product.url)
        productNameLabel.text = product.productName
        priceLabel.text = product.price
        
        if let oldPrice = product.oldPrice {
            addSubview(oldPriceLabel)
            
            NSLayoutConstraint.activate([
                oldPriceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 5),
                oldPriceLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5)
            ])
            
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: oldPrice)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1,
                                         range: NSRange(location: 0, length: attributeString.length))
            oldPriceLabel.attributedText = attributeString
        }
    }
}

// MARK: - ProductViewCell + private extension

private extension ProductViewCell {
    func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(iconView)
        addSubview(productNameLabel)
        addSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            iconView.heightAnchor.constraint(equalToConstant: 120),
            iconView.widthAnchor.constraint(equalToConstant: frame.width),
            
            productNameLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            productNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5),
            productNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5),
            
            priceLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            priceLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5)
        ])
    }
}
