//
//  TrendingNFTCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendingNFTCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let stackView = UIStackView()
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
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
extension TrendingNFTCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(iconImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(changeLabel)
    }
    
    private func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.centerX.equalTo(contentView)
            make.size.equalTo(72)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalTo(contentView)
        }
    }

    private func configureView() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true

        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        nameLabel.textColor = .mainText
        nameLabel.font = .systemFont(ofSize: 9, weight: .bold)
        
        priceLabel.textColor = .subText
        priceLabel.font = .systemFont(ofSize: 9, weight: .regular)
        
        changeLabel.textColor = .mainText
        changeLabel.font = .systemFont(ofSize: 9, weight: .bold)
    }
}

extension TrendingNFTCell {
    
    func configureData(_ data: TrendingNFT) {
        iconImageView.kf.setImage(with: URL(string:data.thumb)!)
        nameLabel.text = data.name
        priceLabel.text = data.data.floorPrice
        let changeData = Double(data.data.floorPriceInUsd24hPercentageChange) ?? 0
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
