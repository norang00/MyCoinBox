//
//  LoadingView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/11/25.
//

import UIKit
import SnapKit

final class LoadingView: BaseView {

    private let activityIndicator = UIActivityIndicatorView()

    override func configureHierarchy() {
        addSubview(activityIndicator)
    }
    
    override func configureLayout() {
        activityIndicator.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
    }

    override func configureView() {
        backgroundColor = .white
        
        activityIndicator.color = .accent
        activityIndicator.style = .large
        
    }
    
    func showSpinner() {
        print(#function)
      activityIndicator.startAnimating()
      isHidden = false
    }

    func hideSpinner() {
        print(#function)
      activityIndicator.stopAnimating()
      isHidden = true
    }
}
