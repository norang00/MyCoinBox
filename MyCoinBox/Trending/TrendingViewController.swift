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
import RxDataSources // 얘는 뷰모델로 가야하려나?

final class TrendingViewController: UIViewController {

    private let trendingView = TrendingView()
    private let trendingViewModel = TrendingViewModel()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<TrendingSectionModel>!

    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = trendingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        trendingView.collectionView.showsHorizontalScrollIndicator = false

        configureCollectionView()
        
        bind()
    }
    
    private func bind() {
        let input = TrendingViewModel.Input(
            
        )
        let output = trendingViewModel.transform(input)
        
        output.resultData
            .bind(to: trendingView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
 
    private func configureCollectionView() {
        trendingView.collectionView.register(TrendingHeaderCell.self,
                                             forCellWithReuseIdentifier: TrendingHeaderCell.identifier)
        trendingView.collectionView.register(TrendingCoinCell.self,
                                             forCellWithReuseIdentifier: TrendingCoinCell.identifier)
        trendingView.collectionView.register(TrendingNFTCell.self,
                                             forCellWithReuseIdentifier: TrendingNFTCell.identifier)
   
        dataSource = RxCollectionViewSectionedReloadDataSource<TrendingSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .coin(let coinData):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCoinCell.identifier,
                                                                  for: indexPath) as! TrendingCoinCell
                    cell.configureData(coinData.item)
                    return cell
                case .nft(let nftData):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingNFTCell.identifier,
                                                                  for: indexPath) as! TrendingNFTCell
                    cell.configureData(nftData)
                    return cell
                }
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                 withReuseIdentifier: TrendingHeaderCell.identifier,
                                                                                 for: indexPath) as! TrendingHeaderCell
                    let section = dataSource.sectionModels[indexPath.section]
                    header.titleLabel.text = section.headerTitle
                    header.dateLabel.text = DateFormatter.update.string(for: Date())
                    return header
                }
                return UICollectionReusableView()
            }
        )
    }
}

enum TrendingSection {
    case coin
    case nft
}

struct TrendingSectionModel {
    var section: TrendingSection
    var headerTitle: String
    var items: [TrendingItem]
}

enum TrendingItem {
    case coin(TrendingCoin)
    case nft(TrendingNFT)
}

extension TrendingSectionModel: SectionModelType {
    typealias Item = TrendingItem

    init(original: TrendingSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
