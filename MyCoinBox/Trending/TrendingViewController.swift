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
        trendingView.trendingNFTCollectionView.showsHorizontalScrollIndicator = false

        configureCollectionView()
        
        bind()
    }
    
    private func bind() {
        let input = TrendingViewModel.Input(
            
        )
        let output = trendingViewModel.transform(input)

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
    }
 
    private func configureCollectionView() {
        trendingView.trendingCoinCollectionView.register(TrendingCoinCell.self,
                                             forCellWithReuseIdentifier: TrendingCoinCell.identifier)
        trendingView.trendingNFTCollectionView.register(TrendingNFTCell.self,
                                             forCellWithReuseIdentifier: TrendingNFTCell.identifier)
    }
}
