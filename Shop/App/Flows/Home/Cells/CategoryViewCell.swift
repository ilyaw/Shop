//
//  CategoryViewCell.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import UIKit
import Kingfisher

class CategoryViewCell: UICollectionViewCell {
    static let reuseId = "CategoryViewCell"
    
    // MARK: - Private properties
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
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
    
    // MARK: - Public methods
    
    func setupCell(category: CategoryInfoProtocol) {
        iconView.kf.setImage(with: URL(string: category.icon))
        titleLabel.text = category.title
    }
    
    override func prepareForReuse() {
        iconView.image = nil
        titleLabel.text = nil
    }
}

// MARK: - CategoryViewCell + private extension

private extension CategoryViewCell {
    func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(iconView)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            iconView.heightAnchor.constraint(equalToConstant: 70),
            iconView.widthAnchor.constraint(equalToConstant: 70),
            
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5)
        ])
    }
}
