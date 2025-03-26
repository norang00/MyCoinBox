//
//  PortfolioView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit

final class PortfolioView: BaseView {
    
    private let navigationBar = UIView()
    private let navigationTitle = UILabel()
    private let borderView = UIView()

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(navigationBar)
        navigationBar.addSubview(navigationTitle)
        addSubview(borderView)

        addSubview(collectionView)
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
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    override func configureView() {
        super.configureView()
        
        navigationTitle.text = Resources.Navigation.Title.portfolio.rawValue
        navigationTitle.textColor = .mainText
        navigationTitle.font = .boldSystemFont(ofSize: 20)
        borderView.backgroundColor = .badgeBg
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        collectionView.register(LikedCoinCell.self,
                                forCellWithReuseIdentifier: LikedCoinCell.identifier)
    }
}
