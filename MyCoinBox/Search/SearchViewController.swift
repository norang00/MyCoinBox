//
//  SearchViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
