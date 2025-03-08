//
//  MarketView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit

final class MarketView: BaseView {
    
    private let navigationBar = UIView()
    private let navigationTitle = UILabel()
    private let borderView = UIView()

    private let headerView = UIStackView()
    private let coinLabel = UILabel()
    let currentButtonView = SortButtonView(frame: .zero, sort: SortValue.current)
    let changeButtonView = SortButtonView(frame: .zero, sort: SortValue.change)
    let priceButtonView = SortButtonView(frame: .zero, sort: SortValue.price)
        
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

        addSubview(headerView)
        headerView.addArrangedSubview(coinLabel)
        headerView.addArrangedSubview(currentButtonView)
        headerView.addArrangedSubview(changeButtonView)
        headerView.addArrangedSubview(priceButtonView)
        
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
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    override func configureView() {
        navigationTitle.text = Resources.Navigation.Title.market.rawValue
        navigationTitle.textColor = .mainText
        navigationTitle.font = .boldSystemFont(ofSize: 20)
        
        borderView.backgroundColor = .lightGray
        
        headerView.axis = .horizontal
        headerView.isLayoutMarginsRelativeArrangement = true
        headerView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        headerView.backgroundColor = .sortBg
        let width: CGFloat = (UIScreen.main.bounds.width-32)/4
        for view in headerView.arrangedSubviews {
            view.snp.makeConstraints { make in
                make.width.equalTo(width)
            }
        }
        
        coinLabel.text = Resources.Writing.coin.rawValue
        coinLabel.textColor = .mainText
        coinLabel.font = .boldSystemFont(ofSize: 12)
    }
}
