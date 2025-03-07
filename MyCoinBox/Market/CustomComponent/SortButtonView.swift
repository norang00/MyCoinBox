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

final class SortButtonView: UIView {
    
    private let label = UILabel()
    private let upTriangle = UIImageView()
    private let downTriangle = UIImageView()
    
    init(frame: CGRect, title: String) {
        label.text = title
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            status = .ascending
        case .ascending:
            status = .descending
        case .descending:
            status = .deselect
        }
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
        addSubview(upTriangle)
        addSubview(downTriangle)
    }
    
    private func configureLayout() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(12)
        }
        upTriangle.snp.makeConstraints { make in
            make.top.equalTo(label)
            make.leading.equalTo(label.snp.trailing)
            make.trailing.equalToSuperview().inset(8)
            make.size.equalTo(10)
        }
        downTriangle.snp.makeConstraints { make in
            make.top.equalTo(upTriangle.snp.bottom).offset(-4)
            make.leading.equalTo(label.snp.trailing)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(label)
            make.size.equalTo(10)
        }
    }

    private func configureView() {
        isUserInteractionEnabled = true
        
        label.textColor = .mainText
        label.font = .boldSystemFont(ofSize: 12)
        
        upTriangle.tintColor = .deselect
        upTriangle.contentMode = .scaleAspectFit
        upTriangle.image = UIImage(systemName: Resources.SystemImage.arrowUp.rawValue)
        
        downTriangle.tintColor = .deselect
        downTriangle.contentMode = .scaleAspectFit
        downTriangle.image = UIImage(systemName: Resources.SystemImage.arrowDown.rawValue)
    }
}
