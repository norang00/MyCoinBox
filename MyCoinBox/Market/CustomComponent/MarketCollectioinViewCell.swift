//
//  MarketCollectioinViewCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import UIKit
import SnapKit

final class MarketCollectioinViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let stackView = UIStackView()
    let coinLabel = UILabel()
    let currentLabel = UILabel()
    let changeStackView = UIStackView()
    let changeRateLabel = UILabel()
    let changePriceLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View
extension MarketCollectioinViewCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        changeStackView.addArrangedSubview(changeRateLabel)
        changeStackView.addArrangedSubview(changePriceLabel)

        addSubview(stackView)
        stackView.addArrangedSubview(coinLabel)
        stackView.addArrangedSubview(currentLabel)
        stackView.addArrangedSubview(changeStackView)
        stackView.addArrangedSubview(priceLabel)
    }
    
    private func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
    }

    private func configureView() {
        stackView.axis = .horizontal
        let width: CGFloat = (UIScreen.main.bounds.width-32)/4
        for view in stackView.arrangedSubviews {
            view.snp.makeConstraints { make in
                make.width.equalTo(width)
            }
        }
        
        coinLabel.font = .systemFont(ofSize: 12, weight: .bold)
        coinLabel.textColor = .mainText
        
        currentLabel.font = .systemFont(ofSize: 12, weight: .regular)
        currentLabel.textColor = .mainText
        currentLabel.textAlignment = .right

        changeStackView.axis = .vertical
        changeStackView.isLayoutMarginsRelativeArrangement = true
        changeStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        changeStackView.distribution = .fillProportionally
        
        changeRateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        changeRateLabel.textAlignment = .right

        changePriceLabel.font = .systemFont(ofSize: 9, weight: .regular)
        changePriceLabel.textAlignment = .right

        priceLabel.font = .systemFont(ofSize: 12, weight: .regular)
        priceLabel.textColor = .mainText
        priceLabel.textAlignment = .right
    }
}

extension MarketCollectioinViewCell {
    
    func configureData(_ data: Market) {
        let sign: Bool = (data.change == "RISE")

        coinLabel.text = data.market

        let currentFormatter = NumberFormatter()
        currentFormatter.maximumFractionDigits = 1
        currentFormatter.numberStyle = .decimal
        currentLabel.text = currentFormatter.string(for: data.tradePrice) ?? ""

        let changeFormatter = NumberFormatter()
        changeFormatter.maximumFractionDigits = 2
        changeFormatter.numberStyle = .decimal
        changeRateLabel.text = (changeFormatter.string(for: data.signedChangeRate) ?? "")+"%"
        changeRateLabel.textColor = sign ? .mainRed : .mainBlue
        changePriceLabel.text = changeFormatter.string(for: data.signedChangePrice) ?? ""
        changePriceLabel.textColor = sign ? .mainRed : .mainBlue
        
        var result: String
        let price = data.accTradePrice24h
        if price >= 1000000 {
            let formatted = round(price).formatted()
            let range = formatted.index(formatted.endIndex, offsetBy: -8)..<formatted.endIndex
            result = formatted.replacingCharacters(in: range, with: "백만")
        } else {
            result = price.formatted()
        }
        priceLabel.text = result
    }
}
