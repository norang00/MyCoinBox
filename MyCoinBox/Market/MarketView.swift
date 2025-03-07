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

    private let headerView = UIView()
    private let coinLabel = UILabel()
    let currentButtonView = SortButtonView(frame: .zero, title: Resources.Writing.current.rawValue)
    let changeButtonView = SortButtonView(frame: .zero, title: Resources.Writing.change.rawValue)
    let priceButtonView = SortButtonView(frame: .zero, title: Resources.Writing.price.rawValue)

    override func configureHierarchy() {
        addSubview(navigationBar)
        navigationBar.addSubview(navigationTitle)

        addSubview(borderView)

        addSubview(headerView)
        headerView.addSubview(coinLabel)
        headerView.addSubview(currentButtonView)
        headerView.addSubview(changeButtonView)
        headerView.addSubview(priceButtonView)
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
        
        coinLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView).inset(24)
            make.centerY.equalTo(headerView)
            make.width.equalTo(180)
        }
        
        currentButtonView.snp.makeConstraints { make in
            make.leading.equalTo(coinLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
        changeButtonView.snp.makeConstraints { make in
            make.leading.equalTo(currentButtonView.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
        priceButtonView.snp.makeConstraints { make in
            make.leading.equalTo(changeButtonView.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.trailing.equalTo(headerView.snp.trailing).inset(8)
        }
    }

    override func configureView() {
        navigationTitle.text = Resources.Navigation.Title.market.rawValue
        navigationTitle.textColor = .mainText
        navigationTitle.font = .boldSystemFont(ofSize: 20)
        
        borderView.backgroundColor = .lightGray
        
        headerView.backgroundColor = .sortBg
        
        coinLabel.text = Resources.Writing.coin.rawValue
        coinLabel.textColor = .mainText
        coinLabel.font = .boldSystemFont(ofSize: 12)
    }
}
