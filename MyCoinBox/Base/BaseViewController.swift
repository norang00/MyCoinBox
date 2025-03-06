//
//  BaseViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation("")
    }
    
    func configureNavigation(_ title: String) {
        navigationItem.title = title
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .blue
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}
