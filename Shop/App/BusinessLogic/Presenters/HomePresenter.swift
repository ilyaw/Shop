//
//  HomePresenter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

// MARK: - Presenter

protocol HomePresenterInput: AnyObject {
    var homeView: HomeView { get }
}

protocol HomePresenterOutput: AnyObject {
    init(router: HomeRouter, requestFactory: HomeRequestFactory)
    func detailProduct(by id: Int)
    func showCatalog()
}

class HomePresenter: NSObject {
    
    // MARK: - Public properties
    
    weak var input: HomePresenterInput?
    
    // MARK: - Private properties
    
    private let router: HomeRouter
    private let requestFactory: HomeRequestFactory
    private var data: HomeResult?
    
    // MARK: - Inits
    
    required init(router: HomeRouter, requestFactory: HomeRequestFactory) {
        self.router = router
        self.requestFactory = requestFactory
    }
    
    // MARK: - Public methods
    
    func setupCollectionView() {
        let layout = createLayout()
        view.collectionView.setCollectionViewLayout(layout, animated: true)
        
        registerCells()
        registerHeaders()
        
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        getData()
    }
}

// MARK: - HomePresenter + UICollectionViewDataSource

extension HomePresenter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        
        if section == 0 {
            return data.adsBanners.count
        } else if section == 1 {
            return data.categores.count
        } else if section == 2 {
            return data.articles.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsBannerViewCell.reuseId,
                                                                for: indexPath) as? AdsBannerViewCell,
                  let banners = data?.adsBanners,
                  let url = URL(string: banners[indexPath.row])
            else { return UICollectionViewCell() }
            
            cell.setupCell(with: url)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.reuseId,
                                                                for: indexPath) as? CategoryViewCell,
                  let categories = data?.categores else { return UICollectionViewCell() }
            
            cell.setupCell(category: categories[indexPath.row])
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesViewCell.reuseId,
                                                                for: indexPath) as? ArticlesViewCell,
                  let articles = data?.articles,
                  let url = URL(string: articles[indexPath.row]) else { return UICollectionViewCell() }
            
            cell.setupCell(with: url)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - HomePrenter + UICollectionViewDelegate

extension HomePresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HomeTitleHeaderView.reuseId,
            for: indexPath) as? HomeTitleHeaderView else { return UICollectionReusableView() }
        
        if indexPath.section == 1 {
            header.titleLabel.text = "Категории"
        } else {
            header.titleLabel.text = "Экспертные статьи"
        }
        
        return header
    }
}

// MARK: - HomePresenter + HomePresenterOutput

extension HomePresenter: HomePresenterOutput {
    func detailProduct(by id: Int) {
        router.showDetailProduct(by: id)
    }
    
    func showCatalog() {
        router.showCatalog()
    }
}

// MARK: HomePresenter + private extension

private extension HomePresenter {
    var view: HomeView {
        return input?.homeView ?? HomeView()
    }
    
    func registerCells() {
        view.collectionView.register(AdsBannerViewCell.self,
                                     forCellWithReuseIdentifier: AdsBannerViewCell.reuseId)
        view.collectionView.register(CategoryViewCell.self,
                                     forCellWithReuseIdentifier: CategoryViewCell.reuseId)
        view.collectionView.register(ArticlesViewCell.self,
                                     forCellWithReuseIdentifier: ArticlesViewCell.reuseId)
    }
    
    func registerHeaders() {
        view.collectionView.register(HomeTitleHeaderView.self,
                                     forSupplementaryViewOfKind: Constant.categoryHeaderId,
                                     withReuseIdentifier: HomeTitleHeaderView.reuseId)
        
        view.collectionView.register(HomeTitleHeaderView.self,
                                     forSupplementaryViewOfKind: Constant.articlesHeaderId,
                                     withReuseIdentifier: HomeTitleHeaderView.reuseId)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return self.createAdsBannerSection()
            } else if sectionNumber == 1 {
                return self.createCategoriesSection()
            } else if sectionNumber == 2 {
                return self.createArticles()
            } else {
                return nil
            }
        }
    }
    
    func createAdsBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 1
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    func createCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                    heightDimension: .absolute(50)),
                  elementKind: Constant.categoryHeaderId,
                  alignment: .topLeading)
        ]
        
        return section
    }
    
    struct Constant {
        static let categoryHeaderId = "categoryHeaderId"
        static let articlesHeaderId = "articlesHeaderId"
    }
    
    func createArticles() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 32
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets.leading = 16
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                    heightDimension: .absolute(50)),
                  elementKind: Constant.articlesHeaderId,
                  alignment: .topLeading)
        ]
        
        return section
    }
    
    func getData() {
        requestFactory.getHomeData { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.data = result
                
                DispatchQueue.main.async {
                    self?.view.collectionView.reloadData()
                }
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0),
                                                  at: .centeredHorizontally,
                                                  animated: true)
        }
    }
}
