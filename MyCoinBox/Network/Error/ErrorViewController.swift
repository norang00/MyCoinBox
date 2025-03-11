//
//  ErrorViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/11/25.
//

import UIKit
import SnapKit
import Network

final class ErrorViewController: UIViewController {

    private let errorView = ErrorView()
    var restartMonitoring: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(errorView)

        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(335)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        errorView.retryButton.addTarget(self, action: #selector(retryTapped),
                                          for: .touchUpInside)
    }
    
    @objc
    private func retryTapped() {
        NetworkMonitor.shared.getCurrentStatus { status in
            switch status {
            case .satisfied:
                print(#function, "satisfied")
                self.dismiss(animated: false)
                self.restartMonitoring?()
            case .unsatisfied:
                print(#function, "unsatisfied")
                self.view.makeToast(Resources.NoInternet.toastMessage.rawValue)
            default:
                print(#function, "default")
                break
            }
        }
    }
}
