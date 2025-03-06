//
//  TrendingViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

final class TrendingViewController: UIViewController {

    let trendingView = TrendingView()
    
    override func loadView() {
        view = trendingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
