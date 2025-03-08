//
//  TrendingHeaderCell.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import UIKit
import SnapKit

final class TrendingHeaderCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View
extension TrendingHeaderCell {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).inset(16)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(16)
        }
    }

    private func configureView() {
        titleLabel.textColor = .mainText
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        dateLabel.textColor = .subText
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
}

extension TrendingHeaderCell {
    
    func configureData(_ title: String, _ date: Date) {
        titleLabel.text = title
        dateLabel.text = DateFormatter.trending.string(for: date)
    }
}
