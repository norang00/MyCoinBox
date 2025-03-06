//
//  MarketViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

final class MarketViewController: BaseViewController {
    
    let marketView = MarketView()
    
    override func loadView() {
        view = marketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
