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
            $0.spacing = 4
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
        
        askPriceLabel.text = String(format: "%.0f", data.askPrice)
        askSizeLabel.text = String(format: "%.3f", data.askSize)
        bidPriceLabel.text = String(format: "%.0f", data.bidPrice)
        bidSizeLabel.text = String(format: "%.3f", data.bidSize)
    }
}
