//
//  SortButton.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

final class SortButtonView: UIView {
    
    enum status {
        case notSelected
        case ascending
        case descending
    }

    private let label = UILabel()
    private let upTriangle = UIImageView()
    private let downTriangle = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        configureTapGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(label)
        addSubview(upTriangle)
        addSubview(downTriangle)
    }
    
    func configureLayout() {
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

    func configureView() {
        isUserInteractionEnabled = true
        
        label.text = "현재가"
        label.textColor = .mainText
        label.font = .boldSystemFont(ofSize: 12)
        
        upTriangle.tintColor = .disabled
        upTriangle.contentMode = .scaleAspectFit
        upTriangle.image = UIImage(systemName: Resources.SystemImage.arrowUp.rawValue)
        
        downTriangle.tintColor = .disabled
        downTriangle.contentMode = .scaleAspectFit
        downTriangle.image = UIImage(systemName: Resources.SystemImage.arrowDown.rawValue)
    }
    
}

// MARK: - Button Tapped
extension SortButtonView {
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    func buttonTapped(_ sender: UIView) {
        print(#function)
        
        upTriangle.tintColor = .accent
    }
}
