//
//  PortfolioViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Toast

final class PortfolioViewController: BaseViewController {
    
    private let portfolioView = PortfolioView()
    private let portfolioViewModel = PortfolioViewModel()

    private let viewDidLoadTrigger = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = portfolioView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        portfolioView.collectionView.showsVerticalScrollIndicator = false
        
        bind()
        viewDidLoadTrigger.accept(())
    }
    
    private func bind() {
        let input = PortfolioViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger
        )
        let output = portfolioViewModel.transform(input: input)
        
        output.likedList
            .drive(portfolioView.collectionView.rx.items(
                cellIdentifier: LikedCoinCell.identifier,
                cellType: LikedCoinCell.self)
            ) { row, item, cell in
                
                print(#function, item)
                cell.configureData(item)
            }
            .disposed(by: disposeBag)
        
        portfolioView.collectionView.rx.modelSelected(LikedCoin.self)
            .subscribe(with: self) { owner, coin in
                let coin = Coin(id: coin.coinId, name: coin.name, symbol: coin.symbol, thumb: coin.thumb)
                let nextVC = DetailViewController()
                nextVC.coin = coin
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
