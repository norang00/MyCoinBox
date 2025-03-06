//
//  PortfolioViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

final class PortfolioViewController: BaseViewController {
    
    let portfolioView = PortfolioView()
    
    override func loadView() {
        view = portfolioView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
