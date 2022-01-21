//
//  CatalogView.swift
//  Shop
//
//  Created by Ilya on 21.01.2022.
//

import UIKit

class CatalogView: UIView {
    
    // MARK: - Public properties
    
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        return collection
    }()
    
    // MARK: - Inits
    
    init() {
        super.init(frame: .zero)
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        collectionView.frame = bounds
    }
}
