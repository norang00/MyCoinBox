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
    private let currentPriceButtonView = SortButtonView()

    override func configureHierarchy() {
        addSubview(navigationBar)
        navigationBar.addSubview(navigationTitle)
        addSubview(borderView)
        
        addSubview(headerView)
        headerView.addSubview(coinLabel)
        headerView.addSubview(currentPriceButtonView)
        

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
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView).inset(24)
            make.centerY.equalTo(headerView)
            make.width.equalTo(180)
        }
        
        currentPriceButtonView.snp.makeConstraints { make in
            make.leading.equalTo(coinLabel.snp.trailing)
            make.top.height.equalToSuperview()
            make.width.equalTo(130)
        }
        
    }

    override func configureView() {
        navigationTitle.text = Resources.Navigation.Title.market.rawValue
        navigationTitle.textColor = .marketTitle
        navigationTitle.font = .boldSystemFont(ofSize: 20)
        
        borderView.backgroundColor = .lightGray
        
        headerView.backgroundColor = .sortBg
        
        coinLabel.text = Resources.Keywords.coin.rawValue
        coinLabel.font = .boldSystemFont(ofSize: 12)
    }

}
