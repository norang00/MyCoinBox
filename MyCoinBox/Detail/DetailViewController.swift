//
//  DetailViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    var id: String = ""
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.label.text = id
    }

}
