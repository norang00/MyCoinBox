//
//  LikedCoinCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/26/25.
//

import UIKit
import SnapKit
import Kingfisher

final class LikedCoinCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    
    let iconImageView = UIImageView()
    let stackView = UIStackView()
    let symbolView = UIView()
    let symbolLabel = UILabel()
    let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        configureData(LikedCoin(coinId: "", name: "", symbol: "", thumb: ""))
    }

}

// MARK: - Setup View
extension LikedCoinCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(iconImageView)

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(symbolView)
        stackView.addArrangedSubview(nameLabel)
        symbolView.addSubview(symbolLabel)
    }
    
    private func configureLayout() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(14)
            make.leading.equalTo(contentView).offset(24)
            make.size.equalTo(36)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(iconImageView)
            make.width.greaterThanOrEqualTo(100)
        }
        symbolLabel.snp.makeConstraints { make in
            make.centerY.equalTo(symbolView)
            make.leading.equalTo(symbolView)
        }
    }

    private func configureView() {
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 18

        stackView.axis = .vertical
        stackView.spacing = 6
        symbolLabel.font = .systemFont(ofSize: 12, weight: .bold)
        nameLabel.textColor = .subText
        nameLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
}

// MARK: - Setup Data
extension LikedCoinCell {
    
    func configureData(_ data: LikedCoin) {
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        if let url = URL(string:data.thumb) {
            iconImageView.kf.setImage(with: url)
        } else {
            iconImageView.image = UIImage(systemName: Resources.SystemImage.bitcoin.rawValue)
        }
    }
}
