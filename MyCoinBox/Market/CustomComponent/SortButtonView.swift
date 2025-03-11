//
//  SortButton.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

enum SortStatus {
    case deselect
    case ascending
    case descending
}

enum SortValue {
    case current
    case change
    case price
    
    var title: String {
        switch self {
        case .current: Resources.ButtonTitle.current.rawValue
        case .change: Resources.ButtonTitle.change.rawValue
        case .price: Resources.ButtonTitle.price.rawValue
        }
    }
}

final class SortButtonView: UIView {
    
    private let label = UILabel()
    
    private let stackView = UIStackView()
    
    private let upTriangle = UIImageView()
    private let downTriangle = UIImageView()
    
    init(frame: CGRect, sort: SortValue) {
        label.text = sort.title
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var value: SortValue?
    
    // Status 관리    
    var status: SortStatus = SortStatus.deselect {
        didSet {
            switch status {
            case .deselect:
                upTriangle.tintColor = .deselect
                downTriangle.tintColor = .deselect
            case .ascending:
                upTriangle.tintColor = .accent
                downTriangle.tintColor = .deselect
            case .descending: //default
                upTriangle.tintColor = .deselect
                downTriangle.tintColor = .accent
            }
        }
    }
    
    func updateStatus() {
        switch status {
        case .deselect:
            status = .descending
        case .descending:
            status = .ascending
        case .ascending:
            status = .deselect
        }
    }
    
    func setDefault() {
        status = .deselect
    }
}

// MARK: - Setup View
extension SortButtonView {
    
    private func setupView() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(label)
        
        addSubview(stackView)
        stackView.addArrangedSubview(upTriangle)
        stackView.addArrangedSubview(downTriangle)
    }
    
    private func configureLayout() {
        snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(32)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
        }
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(label)
            make.leading.equalTo(label.snp.trailing)
            make.trailing.equalToSuperview()
            make.width.equalTo(10)
        }
    }

    private func configureView() {
        isUserInteractionEnabled = true
        
        label.textColor = .mainText
        label.font = .boldSystemFont(ofSize: 12)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = -4
        
        upTriangle.tintColor = .deselect
        upTriangle.contentMode = .scaleAspectFit
        upTriangle.image = UIImage(systemName: Resources.SystemImage.arrowUp.rawValue)
        
        downTriangle.tintColor = .deselect
        downTriangle.contentMode = .scaleAspectFit
        downTriangle.image = UIImage(systemName: Resources.SystemImage.arrowDown.rawValue)
    }
}
