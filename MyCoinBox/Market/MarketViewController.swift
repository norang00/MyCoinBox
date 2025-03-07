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
        marketView.collectionView.showsVerticalScrollIndicator = false
        marketView.collectionView.register(MarketCollectioinViewCell.self, forCellWithReuseIdentifier: MarketCollectioinViewCell.identifier)
        
        bind()
    }
    
    private func bind() {
        let input = MarketViewModel.Input(
            // [TODO] 가능하면 정리...제발
            currentTap: marketView.currentButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: {_ in
                    self.marketView.currentButtonView.updateStatus()
                    self.marketView.changeButtonView.setDefault()
                    self.marketView.priceButtonView.setDefault()
                })
                .map { [weak self] _ in self?.marketView.currentButtonView.status }
                .compactMap { $0 },
            changeTap: marketView.changeButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: {_ in
                    self.marketView.currentButtonView.setDefault()
                    self.marketView.changeButtonView.updateStatus()
                    self.marketView.priceButtonView.setDefault()
                })
                .map { [weak self] _ in self?.marketView.changeButtonView.status }
                .compactMap { $0 },
            priceTap: marketView.priceButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: {_ in
                    self.marketView.currentButtonView.setDefault()
                    self.marketView.changeButtonView.setDefault()
                    self.marketView.priceButtonView.updateStatus()
                })                .map { [weak self] _ in self?.marketView.priceButtonView.status }
                .compactMap { $0 }
        )
        let output = marketViewModel.transform(input)
        
        output.resultList
            .debug("resultList")
            .bind(to: marketView.collectionView.rx.items(
                cellIdentifier: MarketCollectioinViewCell.identifier,
                cellType: MarketCollectioinViewCell.self)) { index, item, cell in
                    print(#function, index, item, cell)
                    
                    cell.configureData(item)
                    
                }
                .disposed(by: disposeBag)
    }
}
