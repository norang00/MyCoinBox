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

final class TrendingViewController: UIViewController {

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
        
        trendingView.searchBar.rx.searchButtonClicked
            .withLatestFrom(trendingView.searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
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
                owner.pushToDetailView(value.item.id)
            }
            .disposed(by: disposeBag)
    }
 
    private func configureCollectionView() {
        trendingView.trendingCoinCollectionView.keyboardDismissMode = .onDrag
        trendingView.trendingCoinCollectionView.register(TrendingCoinCell.self,
                                                         forCellWithReuseIdentifier: TrendingCoinCell.identifier)
        
        trendingView.trendingNFTCollectionView.showsHorizontalScrollIndicator = false
        trendingView.trendingNFTCollectionView.register(TrendingNFTCell.self,
                                                        forCellWithReuseIdentifier: TrendingNFTCell.identifier)
    }
    
    private func pushToSearchView(_ query: String) {
        let nextVC = SearchViewController()
        nextVC.query = query
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func pushToDetailView(_ id: String) {
        let nextVC = DetailViewController()
        nextVC.id = id
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
