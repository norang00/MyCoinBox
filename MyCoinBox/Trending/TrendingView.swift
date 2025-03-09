//
//  TrendingView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit

final class TrendingView: BaseView {
    
    private let navigationBar = UIView()
    private let navigationTitle = UILabel()
    private let borderView = UIView()

    private let searchBarBackground = UIView()
    let searchBar = UISearchBar()

    private let trendingCoinTitleView = UIView()
    private let trendingCoinTitleLabel = UILabel()
    let updateLabel = UILabel()
    lazy var trendingCoinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCoinLayout())
    
    private let trendingNFTTitleView = UIView()
    private let trendingNFTTitleLabel = UILabel()
    lazy var trendingNFTCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createNFTLayout())

    private func createCoinLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1/7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                    heightDimension: .fractionalHeight(1.0))
        let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitems: [item])
        
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(1.0))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [innerGroup])
        outerGroup.interItemSpacing = .fixed(32)
        
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createNFTLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(72),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.5),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 20, bottom: 8, trailing: 20)

        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    override func configureHierarchy() {
        addSubview(navigationBar)
        navigationBar.addSubview(navigationTitle)
        addSubview(borderView)

        addSubview(searchBarBackground)
        searchBarBackground.addSubview(searchBar)
        
        addSubview(trendingCoinTitleView)
        trendingCoinTitleView.addSubview(trendingCoinTitleLabel)
        trendingCoinTitleView.addSubview(updateLabel)
        addSubview(trendingCoinCollectionView)
        
        addSubview(trendingNFTTitleView)
        trendingNFTTitleView.addSubview(trendingNFTTitleLabel)
        addSubview(trendingNFTCollectionView)
    }
    
    override func configureLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        navigationTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        searchBarBackground.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }

        searchBar.snp.makeConstraints { make in
            make.edges.equalTo(searchBarBackground).inset(8)
        }
        
        trendingCoinTitleView.snp.makeConstraints { make in
            make.top.equalTo(searchBarBackground.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        trendingCoinTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(trendingCoinTitleView)
            make.leading.equalTo(trendingCoinTitleView).offset(20)
        }
        
        updateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(trendingCoinTitleView)
            make.trailing.equalTo(trendingCoinTitleView).inset(20)
        }
        
        trendingCoinCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendingCoinTitleView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(320)
        }
        
        trendingNFTTitleView.snp.makeConstraints { make in
            make.top.equalTo(trendingCoinCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        trendingNFTTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(trendingNFTTitleView)
            make.leading.equalTo(trendingNFTTitleView).offset(20)
        }
        
        trendingNFTCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendingNFTTitleView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
    }

    override func configureView() {
        super.configureView()
        
        navigationTitle.text = Resources.Navigation.Title.trending.rawValue
        navigationTitle.textColor = .mainText
        navigationTitle.font = .boldSystemFont(ofSize: 20)
        borderView.backgroundColor = .lightGray

        searchBarBackground.layer.borderColor = UIColor.subText.cgColor
        searchBarBackground.layer.borderWidth = 1
        searchBarBackground.layer.cornerRadius = 25

        let empty = UIImage()
        searchBar.placeholder = Resources.Writing.placeholder.rawValue
        searchBar.setBackgroundImage(empty, for: .any, barMetrics: .default)
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .regular)
        searchBar.searchTextField.backgroundColor = .white

        trendingCoinTitleLabel.text = Resources.Writing.trendingKeyword.rawValue
        trendingCoinTitleLabel.textColor = .mainText
        trendingCoinTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        updateLabel.textColor = .subText
        updateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        trendingNFTTitleLabel.text = Resources.Writing.trendingNFT.rawValue
        trendingNFTTitleLabel.textColor = .mainText
        trendingNFTTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
}
