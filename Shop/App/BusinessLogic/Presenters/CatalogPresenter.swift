//
//  CatalogPresenter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

// MARK: - Presenter

protocol CatalogPresenterInput: AnyObject {
    var catalogView: CatalogView { get }
}

class CatalogPresenter: NSObject {
    
    // MARK: - Public properties
    
    weak var input: CatalogPresenterInput?
    
    // MARK: - Private properties
    
    private let router: HomeRouter
    private let requestFactory: ProductRequestFactory
    private let productViewModelFactory = ProductViewModelFactory()
    private let catalogId: Int
    
    private var productViewModels: [ProductViewModel] = []
    
    // MARK: - Inits
    
    required init(router: HomeRouter,
                  requestFactory: ProductRequestFactory,
                  catalogId: Int) {
        self.router = router
        self.requestFactory = requestFactory
        self.catalogId = catalogId
    }
    
    // MARK: - Public methods
    
    func setupCollectionView() {
        let layout = createLayout()
        view.collectionView.setCollectionViewLayout(layout, animated: true)
        
        registerCells()
        
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        getData()
    }
    
    func openProduct(by id: Int) {
        router.showDetailProduct(by: id)
    }
    
    deinit {
        print("deinit CatalogPresenter")
    }
}

// MARK: - CatalogPresenter + UICollectionViewDelegate

extension CatalogPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productId = productViewModels[indexPath.row].id
        router.showDetailProduct(by: productId)
    }
}

// MARK: - CatalogPresenter + UICollectionViewDataSource

extension CatalogPresenter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return productViewModels.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.reuseId,
                                                                for: indexPath) as? ProductViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setupCell(product: productViewModels[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
}

// MARK: - CatalogPresenter + private extension

private extension CatalogPresenter {
    var view: CatalogView {
        return input?.catalogView ?? CatalogView()
    }
    
    func registerCells() {
        view.collectionView.register(ProductViewCell.self,
                                     forCellWithReuseIdentifier: ProductViewCell.reuseId)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.createProductsSection()
            default: return nil
            }
        }
    }
    
    func createProductsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(260))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1000))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        return section
    }
    
    func getData() {
        requestFactory.getCatalog(numberPage: 1, categoryId: catalogId) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.productViewModels = self.productViewModelFactory.constuctViewModels(products: result.products)
                    
                    DispatchQueue.main.async {
                        self.view.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
}
