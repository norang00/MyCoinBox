//
//  TrendingViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class TrendingViewController: BaseViewController {

    private let trendingView = TrendingView()
    private let trendingViewModel = TrendingViewModel()

    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = trendingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        configureCollectionView()
        
        trendingView.loadingView.showSpinner()

        bind()
    }
    
    private func bind() {
        let input = TrendingViewModel.Input(
            
        )
        let output = trendingViewModel.transform(input)

        output.update
            .bind(with: self) { owner, date in
                owner.trendingView.updateLabel.text = DateFormatter.trending.string(for: date)
            }
            .disposed(by: disposeBag)
        
        output.coinData
            .drive(trendingView.trendingCoinCollectionView.rx.items(
                cellIdentifier: TrendingCoinCell.identifier,
                cellType: TrendingCoinCell.self)) { index, item, cell in
                    cell.configureData(item.item)
                }
                .disposed(by: disposeBag)

        output.nftData
            .drive(trendingView.trendingNFTCollectionView.rx.items(
                cellIdentifier: TrendingNFTCell.identifier,
                cellType: TrendingNFTCell.self)) { index, item, cell in
                    cell.configureData(item)
                }
                .disposed(by: disposeBag)
        
        output.nftData
            .asObservable()
            .bind(with: self) { owner, value in
                owner.trendingView.loadingView.hideSpinner()
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .bind(with: self) { owner, error in
                owner.showAlert(title: Resources.Alert.Title.warning.rawValue,
                                message: error.rawValue)
            }
            .disposed(by: disposeBag)
        
        trendingView.searchBar.rx.searchButtonClicked
            .withLatestFrom(trendingView.searchBar.rx.text.orEmpty)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .bind(with: self) { owner, value in
                if !value.isEmpty {
                    owner.pushToSearchView(value)
                }
                owner.trendingView.searchBar.text = ""
                owner.trendingView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        trendingView.trendingCoinCollectionView.rx.modelSelected(TrendingCoin.self)
            .bind(with: self) { owner, value in
                let item = value.item
                let coin = Coin(id: item.id, name: item.name, symbol: item.symbol, thumb: item.thumb)
                owner.pushToDetailView(coin)
            }
            .disposed(by: disposeBag)
    }
 
    private func configureCollectionView() {
        trendingView.trendingCoinCollectionView.isScrollEnabled = false
        trendingView.trendingCoinCollectionView.register(TrendingCoinCell.self,
                                                         forCellWithReuseIdentifier: TrendingCoinCell.identifier)
        
        trendingView.trendingNFTCollectionView.showsHorizontalScrollIndicator = false
        trendingView.trendingNFTCollectionView.register(TrendingNFTCell.self,
                                                        forCellWithReuseIdentifier: TrendingNFTCell.identifier)
    }
    
    private func pushToSearchView(_ query: String) {
        let nextVC = SearchViewController()
        nextVC.searchView.searchBar.text = query
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func pushToDetailView(_ coin: Coin) {
        let nextVC = DetailViewController()
        nextVC.coin = coin
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
