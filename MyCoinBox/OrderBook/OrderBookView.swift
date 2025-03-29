//
//  OrderBookView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/27/25.
//

import UIKit
import SnapKit

final class OrderbookView: BaseView {
    
    private let navigationBar = UIView()
    private let navigationTitle = UILabel()
    private let borderView = UIView()
    
    // Temp
    private let currencyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC 기준"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private var headerStack: UIStackView!
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
        navigationBar.addSubview(currencyInfoLabel)
        addSubview(borderView)
        
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalCentering
        headerStack.alignment = .center
        headerStack.backgroundColor = .sortBg
        headerStack.isLayoutMarginsRelativeArrangement = true
        headerStack.layoutMargins = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        
        let askLabel = UILabel()
        askLabel.text = "매도 (수량 / 가격)"
        askLabel.textColor = .mainText
        askLabel.textAlignment = .center
        askLabel.font = .boldSystemFont(ofSize: 12)

        let bidLabel = UILabel()
        bidLabel.text = "매수 (가격 / 수량)"
        bidLabel.textColor = .mainText
        bidLabel.textAlignment = .center
        bidLabel.font = .boldSystemFont(ofSize: 12)

        headerStack.addArrangedSubview(askLabel)
        headerStack.addArrangedSubview(bidLabel)

        addSubview(headerStack)
        self.headerStack = headerStack
        
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
        currencyInfoLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        borderView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    override func configureView() {
        super.configureView()
        
        navigationTitle.text = Resources.Navigation.Title.orderbook.rawValue
        navigationTitle.textColor = .mainText
        navigationTitle.font = .boldSystemFont(ofSize: 20)
        borderView.backgroundColor = .badgeBg
        
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        collectionView.register(OrderBookCell.self,
                                forCellWithReuseIdentifier: OrderBookCell.identifier)
    }
}
