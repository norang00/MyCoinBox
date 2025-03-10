//
//  SearchCoinCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/9/25.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchCoinCell: UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    
    let iconImageView = UIImageView()
    let stackView = UIStackView()
    let symbolView = UIView()
    let symbolLabel = UILabel()
    let rankLabel = RankLabel()
    let nameLabel = UILabel()
    let likeButton = UIButton()
    var onLikeButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        configureData(SearchCoin(id: "", name: "", symbol: "", marketCapRank: 0, thumb: ""), false)
    }

    @objc private func likeButtonTapped() {
        onLikeButtonTapped?()
    }
}

// MARK: - Setup View
extension SearchCoinCell {
    
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
        symbolView.addSubview(rankLabel)

        contentView.addSubview(likeButton)
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
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(symbolView)
            make.leading.equalTo(symbolLabel.snp.trailing).offset(8)
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(stackView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(24)
            make.size.equalTo(40)
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
        
        likeButton.tintColor = .accent
        likeButton.setImage(UIImage(systemName: Resources.SystemImage.unlike.rawValue), for: .normal)
        likeButton.imageView?.contentMode = .scaleAspectFit
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Setup Data
extension SearchCoinCell {
    
    func configureData(_ data: SearchCoin, _ isLiked: Bool) {
        iconImageView.kf.setImage(with: URL(string:data.thumb)!)
        symbolLabel.text = data.symbol
        rankLabel.text = "#\(data.marketCapRank)"
        nameLabel.text = data.name
        likeButton.setImage(UIImage(systemName: isLiked ?
                                    Resources.SystemImage.like.rawValue :
                                    Resources.SystemImage.unlike.rawValue), for: .normal)
    }
}
