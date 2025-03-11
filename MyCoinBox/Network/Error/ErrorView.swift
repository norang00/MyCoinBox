//
//  ErrorView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/11/25.
//

import UIKit

final class ErrorView: BaseView {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let borderView = UIView()
    let retryButton = UIButton()
    
    override func configureHierarchy() {
        [titleLabel, descriptionLabel, borderView, retryButton].forEach {
            addSubview($0)
        }
    }

    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        retryButton.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }

    override func configureView() {
        super.configureView()
     
        backgroundColor = .white
        
        titleLabel.text = Resources.NoInternet.title.rawValue
        titleLabel.textColor = .accent
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.text = Resources.NoInternet.description.rawValue
        descriptionLabel.textColor = .accent
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        descriptionLabel.numberOfLines = 0

        borderView.backgroundColor = .badgeBg
        
        retryButton.setTitle(Resources.NoInternet.retry.rawValue, for: .normal)
        retryButton.setTitleColor(.mainText, for: .normal)
        retryButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
}
