//
//  MarketViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class MarketViewController: BaseViewController {
    
    let marketView = MarketView()
    let marketViewModel = MarketViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = marketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        bind()
    }
    
    private func bind() {
        let input = MarketViewModel.Input(
            // [TODO] 너무 조잡한가?
            currentTap: marketView.currentButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: {_ in self.marketView.currentButtonView.updateStatus()})
                .map { [weak self] _ in self?.marketView.currentButtonView.status }
                .compactMap { $0 },
            changeTap: marketView.changeButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: {_ in self.marketView.changeButtonView.updateStatus()})
                .map { [weak self] _ in self?.marketView.changeButtonView.status }
                .compactMap { $0 },
            priceTap: marketView.priceButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: {_ in self.marketView.priceButtonView.updateStatus()})
                .map { [weak self] _ in self?.marketView.priceButtonView.status }
                .compactMap { $0 }
        )
        let output = marketViewModel.transform(input)
        
        
    }

}
