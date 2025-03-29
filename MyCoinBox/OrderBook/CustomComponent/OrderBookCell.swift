//
//  OrderBookCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/27/25.
//

import UIKit
import SnapKit

final class OrderBookCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let bidStack = UIStackView()
    private let askStack = UIStackView()
    
    private let bidPriceLabel = UILabel()
    private let bidSizeLabel = UILabel()
    
    private let askPriceLabel = UILabel()
    private let askSizeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bidPriceLabel.text = nil
        bidSizeLabel.text = nil
        askPriceLabel.text = nil
        askSizeLabel.text = nil
    }
}

// MARK: - Setup View
extension OrderBookCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureStyle()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(bidStack)
        contentView.addSubview(askStack)
        
        bidStack.addArrangedSubview(bidPriceLabel)
        bidStack.addArrangedSubview(bidSizeLabel)
        
        askStack.addArrangedSubview(askPriceLabel)
        askStack.addArrangedSubview(askSizeLabel)
    }
    
    private func configureLayout() {
        bidStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        askStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureStyle() {
        [bidStack, askStack].forEach {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .equalCentering
        }
        
        bidPriceLabel.font = .systemFont(ofSize: 12, weight: .bold)
        bidPriceLabel.textColor = .systemBlue
        bidSizeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        bidSizeLabel.textColor = .systemBlue
        
        askPriceLabel.font = .systemFont(ofSize: 12, weight: .bold)
        askPriceLabel.textColor = .systemRed
        askSizeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        askSizeLabel.textColor = .systemRed
    }
}

// MARK: - Setup Data
extension OrderBookCell {
    
    func configureData(_ data: OrderBookUnit) {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .decimal
        priceFormatter.usesGroupingSeparator = true
        priceFormatter.groupingSeparator = ","  // 세 자리마다 쉼표
        priceFormatter.minimumFractionDigits = 0
        priceFormatter.maximumFractionDigits = 0

        let sizeFormatter = NumberFormatter()
        sizeFormatter.numberStyle = .decimal
        sizeFormatter.usesGroupingSeparator = true
        sizeFormatter.groupingSeparator = ","
        sizeFormatter.minimumFractionDigits = 3
        sizeFormatter.maximumFractionDigits = 3

        askPriceLabel.text = priceFormatter.string(from: NSNumber(value: data.askPrice))
        askSizeLabel.text = sizeFormatter.string(from: NSNumber(value: data.askSize))
        bidPriceLabel.text = priceFormatter.string(from: NSNumber(value: data.bidPrice))
        bidSizeLabel.text = sizeFormatter.string(from: NSNumber(value: data.bidSize))

        askPriceLabel.textAlignment = .left
        askSizeLabel.textAlignment = .left
        bidPriceLabel.textAlignment = .left
        bidSizeLabel.textAlignment = .left
    }
    
//    func configureData(_ data: OrderBookUnit) {
//        askPriceLabel.text = String(format: "%.0f", data.askPrice)
//        askSizeLabel.text = String(format: "%.3f", data.askSize)
//        bidPriceLabel.text = String(format: "%.0f", data.bidPrice)
//        bidSizeLabel.text = String(format: "%.3f", data.bidSize)
//        askPriceLabel.textAlignment = .left
//        askSizeLabel.textAlignment = .left
//        bidPriceLabel.textAlignment = .left
//        bidSizeLabel.textAlignment = .left
//    }
}
