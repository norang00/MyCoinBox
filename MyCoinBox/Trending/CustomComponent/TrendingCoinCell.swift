//
//  TrendingCoinCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendingCoinCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let scoreLabel = UILabel()
    let iconImageView = UIImageView()
    let stackView = UIStackView()
    let symbolLabel = UILabel()
    let nameLabel = UILabel()
    let changeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View
extension TrendingCoinCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(scoreLabel)
        addSubview(iconImageView)
        
        addSubview(stackView)
        stackView.addArrangedSubview(symbolLabel)
        stackView.addArrangedSubview(nameLabel)
        
        addSubview(changeLabel)
    }
    
    private func configureLayout() {
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.size.equalTo(12)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(scoreLabel.snp.trailing).offset(4)
            make.size.equalTo(26)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
        }
        changeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.greaterThanOrEqualTo(stackView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView)
        }
    }

    private func configureView() {
        scoreLabel.textColor = .mainText
        scoreLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        symbolLabel.textColor = .mainText
        symbolLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        nameLabel.textColor = .subText
        nameLabel.font = .systemFont(ofSize: 9, weight: .regular)
        
        changeLabel.textColor = .mainText
        changeLabel.font = .systemFont(ofSize: 9, weight: .bold)
    }
}

extension TrendingCoinCell {
    
    func configureData(_ data: TrendingCoinItem) {
        scoreLabel.text = "\(data.score+1)"
        iconImageView.kf.setImage(with: URL(string:data.thumb)!)
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        
        let changeData = data.data.priceChangePercentage24h["kwr"] ?? 0
        let formatted = NumberFormatter.formatter.string(for: changeData) ?? ""
        if changeData > 0 {
            changeLabel.textColor = .mainRed
            changeLabel.text = "▲ \(formatted)%"
        } else if changeData < 0 {
            changeLabel.textColor = .mainBlue
            changeLabel.text = "▼ \(formatted)%"
        } else {
            changeLabel.text = "\(changeData)%"
        }
    }
}
