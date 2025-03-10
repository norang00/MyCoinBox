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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configureData(TrendingCoinItem(id: "", name: "", symbol: "", thumb: "", score: 0, data: TrendingCoinData(priceChangePercentage24h: ["":0.0])))
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
        contentView.addSubview(scoreLabel)
        contentView.addSubview(iconImageView)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(symbolLabel)
        stackView.addArrangedSubview(nameLabel)
        
        contentView.addSubview(changeLabel)
    }
    
    private func configureLayout() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.size.equalTo(14)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(scoreLabel.snp.trailing).offset(8)
            make.size.equalTo(26)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.width.greaterThanOrEqualTo(50)
        }
        changeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(stackView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView)
        }
    }

    private func configureView() {
        scoreLabel.textColor = .mainText
        scoreLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        iconImageView.layer.cornerRadius = 13
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2
        
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
        scoreLabel.textAlignment = .center
        
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        
        let changeData = data.data.priceChangePercentage24h["krw"] ?? 0
        let formatted = NumberFormatter.formatter.string(for: abs(changeData)) ?? ""
        if changeData > 0 {
            changeLabel.textColor = .mainRed
            changeLabel.text = "▲ \(formatted)%"
        } else if changeData < 0 {
            changeLabel.textColor = .mainBlue
            changeLabel.text = "▼ \(formatted)%"
        } else {
            changeLabel.text = "\(changeData)%"
        }
        changeLabel.textAlignment = .right
        
        if let url = URL(string:data.thumb) {
            iconImageView.kf.setImage(with: url)
        } else {
            iconImageView.image = UIImage(systemName: Resources.SystemImage.bitcoin.rawValue)
        }
    }
}
