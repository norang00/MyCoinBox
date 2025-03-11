//
//  MarketCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import UIKit
import SnapKit

final class MarketCell: UICollectionViewCell {
    
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
extension MarketCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(coinLabel)
        stackView.addArrangedSubview(currentLabel)
        stackView.addArrangedSubview(changeStackView)
        stackView.addArrangedSubview(priceLabel)
        changeStackView.addArrangedSubview(changeRateLabel)
        changeStackView.addArrangedSubview(changePriceLabel)
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

extension MarketCell {
    
    func configureData(_ data: MarketData) {
        let sign: Bool = (data.change == "RISE")
        
        coinLabel.text = convertCoinName(data.market)
        
        let currentText = NumberFormatter.formatterDigit0.string(for: data.tradePrice) ?? ""
        currentLabel.text = currentText
        
        let changeRateText = NumberFormatter.formatterDigit2.string(for: data.signedChangeRate) ?? ""
        changeRateLabel.text = changeRateText+"%"
        changeRateLabel.textColor = sign ? .mainRed : .mainBlue
        
        let changePriceText = NumberFormatter.formatterDigit2.string(for: data.signedChangePrice) ?? ""
        changePriceLabel.text = changePriceText
        changePriceLabel.textColor = sign ? .mainRed : .mainBlue
        
        priceLabel.text = convertPriceString(data.accTradePrice24h)
    }
    
    private func convertCoinName(_ input: String) -> String {
        let pattern = #"([A-Z]+)-([A-Z]+)"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let transformed = regex.stringByReplacingMatches(
            in: input, options: [],
            range: NSRange(location: 0, length: input.utf16.count),
            withTemplate: "$2/$1")
        return transformed
    }
    
    private func convertPriceString(_ price: Double) -> String {
        var result: String
        if price >= 1000000 {
            let formatted = round(price).formatted()
            let range = formatted.index(formatted.endIndex, offsetBy: -8)..<formatted.endIndex
            result = formatted.replacingCharacters(in: range, with: "백만")
        } else {
            result = price.formatted()
        }
        return result
    }
}
