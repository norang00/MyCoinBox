//
//  BaseViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import Network
import Toast

class BaseViewController: UIViewController {
    
    let networkMonitor = NetworkMonitor.shared
    var noConnection: Bool = false
    
    deinit {
        networkMonitor.stopMonitoring()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMonitoring()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Resources.Writing.confirm.rawValue, style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    private func startMonitoring() {
        networkMonitor.startMonitoring { [weak self] status in
            switch status {
            case .unsatisfied:
                self?.showErrorView()
            default:
                break
            }
        }
    }
    
    private func showErrorView() {
        networkMonitor.stopMonitoring()
        let errorVC = ErrorViewController()
        errorVC.modalPresentationStyle = .overCurrentContext
        errorVC.restartMonitoring = { [weak self] in
            self?.startMonitoring()
        }
        present(errorVC, animated: false)
    }
}
