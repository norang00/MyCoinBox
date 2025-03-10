//
//  DetailViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Kingfisher
import Toast

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    let detailViewModel = DetailViewModel()
    
    let dbManager = DBManager()
    var likedList: Results<LikedItem>!
    
    var id: String = ""
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailViewController, id", id)
        
        bind()
    }
    
    private func bind() {
        let input = DetailViewModel.Input(
            id: id,
            likeTap: detailView.likeButton.rx.tap
        )
        let output = detailViewModel.transform(input)

        detailView.backButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.popView()
            }
            .disposed(by: disposeBag)
        
        output.result
            .drive(with: self) { owner, data in
                guard let data = data.first else { return }
                owner.drawData(data)
            }
            .disposed(by: disposeBag)

//            .bind(with: self) { owner, data in
//                var isLiked = owner.checkIsLiked(data.id)
//                    cell.configureData(item, isLiked)
//                    cell.onLikeButtonTapped = { [weak self] in
//                        guard let self = self else { return }
//
//                        if isLiked {
//                            self.dbManager.deleteLikedItem(coinId: data.id)
//                            self.searchView.makeToast("\(data.name)이 즐겨찾기에서 제거되었습니다.", duration: 1.0)
//                        } else {
//                            self.dbManager.createLikedItem(coinId: data.id)
//                            self.searchView.makeToast("\(data.name)이 즐겨찾기되었습니다.", duration: 1.0)
//                        }
//                        isLiked.toggle()
//                        cell.configureData(item, isLiked)
//                    }
//                }
//                .disposed(by: disposeBag)
    }
    
    private func drawData(_ data: CoinDetail) {
        if let url = URL(string:data.image) {
            detailView.iconImageView.kf.setImage(with: url)
        }
        detailView.coinSymbolLabel.text = data.symbol
        
        let isLiked = checkIsLiked(data.id)
        detailView.likeButton.setImage(UIImage(systemName: isLiked ?
                                               Resources.SystemImage.like.rawValue :
                                                Resources.SystemImage.unlike.rawValue), for: .normal)

        detailView.currentPriceLabel.text = "₩ \(data.currentPrice.formatted())"
        
        if let changeData = data.priceChangePercentage24h {
            let formatted = NumberFormatter.formatter.string(for: abs(changeData)) ?? ""
            if changeData > 0 {
                detailView.changePercentLabel.textColor = .mainRed
                detailView.changePercentLabel.text = "▲ \(formatted)%"
            } else if changeData < 0 {
                detailView.changePercentLabel.textColor = .mainBlue
                detailView.changePercentLabel.text = "▼ \(formatted)%"
            } else {
                detailView.changePercentLabel.text = "\(changeData)%"
            }
        }
        
        if let date = DateFormatter.isoFormatter.date(from: data.lastUpdated) {
            print("date", date)
            let formattedString = DateFormatter.update.string(from: date)
            detailView.updateLabel.text = formattedString
        }
        
        if let formatted = NumberFormatter.formatter.string(for: data.high24h) {
            detailView.high24hValueLabel.text = "₩\(formatted)"
        }

        if let formatted = NumberFormatter.formatter.string(for: data.low24h) {
            detailView.low24hValueLabel.text = "₩\(formatted)"
        }
        
        detailView.highestValueLabel.text = "₩\(data.ath.formatted())"
        if let date = DateFormatter.isoFormatter.date(from: data.athDate) {
            let formattedString = DateFormatter.basic.string(from: date)
            detailView.highestDateLabel.text = formattedString
        }

        detailView.lowestValueLabel.text = "₩\(data.atl.formatted())"
        if let date = DateFormatter.isoFormatter.date(from: data.atlDate) {
            let formattedString = DateFormatter.basic.string(from: date)
            detailView.lowestDateLabel.text = formattedString
        }

        if let formatted = NumberFormatter.formatter.string(for: data.marketCap) {
            detailView.marketCapValueLabel.text = "₩\(formatted)"
        }
        if let formatted = NumberFormatter.formatter.string(for: data.fullyDilutedValuation) {
            detailView.fdvValueLabel.text = "₩\(formatted)"
        }
        if let formatted = NumberFormatter.formatter.string(for: data.totalVolume) {
            detailView.totalVolumeValueLabel.text = "₩\(formatted)"
        }

    }
    
    private func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func checkIsLiked(_ id: String) -> Bool {
        likedList = dbManager.getLikedItem()
        let result = likedList.where { $0.coinId == id }
        return !result.isEmpty
    }
}
