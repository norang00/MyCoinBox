//
//  OrderBookViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/27/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Toast

final class OrderBookViewController: BaseViewController {
    
    private let orderbookView = OrderbookView()
    private let orderbookViewModel = OrderBookViewModel()

    private let viewDidLoadTrigger = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = orderbookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        orderbookView.collectionView.showsVerticalScrollIndicator = false
        
        bind()
        viewDidLoadTrigger.accept(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        WebSocketManager.shared.disconnect()
    }
    
    private func bind() {
        let input = OrderBookViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger
        )
        let output = orderbookViewModel.transform(input: input)
        
        output.resultList
            .drive(orderbookView.collectionView.rx.items(
                cellIdentifier: OrderBookCell.identifier,
                cellType: OrderBookCell.self)
            ) { row, item, cell in
                
                cell.configureData(item)
            }
            .disposed(by: disposeBag)
    }
}
