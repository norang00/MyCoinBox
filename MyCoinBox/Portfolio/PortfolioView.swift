//
//  PortfolioView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit

final class PortfolioView: BaseView {
    
    private let label = UILabel()

    override func configureHierarchy() {
        addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
    }

    override func configureView() {
        super.configureView()
        
        label.text = "준비중입니다"
    }

}
