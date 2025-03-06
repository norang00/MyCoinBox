//
//  DetailView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    
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
        label.text = "DetailView"
    }

}
