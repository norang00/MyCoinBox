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
    
    private let marketView = MarketView()
    private let marketViewModel = MarketViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = marketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        marketView.collectionView.showsVerticalScrollIndicator = false
        marketView.collectionView.register(MarketCell.self, forCellWithReuseIdentifier: MarketCell.identifier)
        marketView.loadingView.showSpinner()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        marketViewModel.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        marketViewModel.stopTimer()
    }
    
    private func bind() {
        let input = MarketViewModel.Input(
            currentTap: marketView.currentButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: { [weak self] _ in
                    self?.marketView.currentButtonView.updateStatus()
                    self?.marketView.changeButtonView.setDefault()
                    self?.marketView.priceButtonView.setDefault()
                })
                .map { [weak self] _ in
                    self?.marketView.currentButtonView.status
                }
                .compactMap { $0 },
            changeTap: marketView.changeButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: { [weak self] _ in
                    self?.marketView.currentButtonView.setDefault()
                    self?.marketView.changeButtonView.updateStatus()
                    self?.marketView.priceButtonView.setDefault()
                })
                .map { [weak self] _ in self?.marketView.changeButtonView.status }
                .compactMap { $0 },
            priceTap: marketView.priceButtonView.rx.tapGesture()
                .when(.recognized)
                .do(onNext: { [weak self] _ in
                    self?.marketView.currentButtonView.setDefault()
                    self?.marketView.changeButtonView.setDefault()
                    self?.marketView.priceButtonView.updateStatus()
                })
                .map { [weak self] _ in self?.marketView.priceButtonView.status }
                .compactMap { $0 }
        )
        let output = marketViewModel.transform(input)
        
        output.resultList
            .asObservable()
            .bind(with: self) { owner, value in
                owner.marketView.loadingView.hideSpinner()
            }
            .disposed(by: disposeBag)
        
        output.resultList
            .drive(marketView.collectionView.rx.items(
                cellIdentifier: MarketCell.identifier,
                cellType: MarketCell.self)) { index, item, cell in
                    cell.configureData(item)
                }
                .disposed(by: disposeBag)
                
        output.errorMessage
            .bind(with: self) { owner, error in
                owner.showAlert(title: Resources.Alert.Title.warning.rawValue,
                                message: error.rawValue)
            }
            .disposed(by: disposeBag)
    }
}
