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
import DGCharts

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
        
        detailView.likeButton.rx.tap
            .bind(with: self) { owner, _ in
                var isLiked = owner.checkIsLiked(owner.id)
                if isLiked {
                    self.dbManager.deleteLikedItem(coinId: owner.id)
                    self.detailView.makeToast("즐겨찾기에서 제거되었습니다.", duration: 1.0)
                } else {
                    self.dbManager.createLikedItem(coinId: owner.id)
                    self.detailView.makeToast("즐겨찾기되었습니다.", duration: 1.0)
                }
                isLiked.toggle()
                owner.updateLikeButtonUI(isLiked)
            }
            .disposed(by: disposeBag)
        
        output.result
            .drive(with: self) { owner, data in
                guard let data = data.first else { return }
                owner.drawData(data)
            }
            .disposed(by: disposeBag)
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
        
        if let chartData = data.sparklineIn7d {
            drawChart(chartData)
        }
    }
    
    private func drawChart(_ data: SparklineData) {
        let chartData = convertChartData(data)
        let dataSet = LineChartDataSet(entries: chartData)
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.setColor(.mainBlue)
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        
        let gradientColors = [UIColor.mainBlue.cgColor, UIColor.white.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        let fill = LinearGradientFill(gradient: gradient!, angle: 90)
        dataSet.fill = fill
        dataSet.drawFilledEnabled = true

        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        detailView.changeChart.data = data
    }
    
    private func convertChartData(_ data: SparklineData) -> [ChartDataEntry] {
        var result: [ChartDataEntry] = []
        for index in 0..<data.price.count {
            let entry = ChartDataEntry(x: Double(index), y: data.price[Int(index)])
            result.append(entry)
        }
        return result
    }
    
    private func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func checkIsLiked(_ id: String) -> Bool {
        likedList = dbManager.getLikedItem()
        let result = likedList.where { $0.coinId == id }
        return !result.isEmpty
    }
    
    private func updateLikeButtonUI(_ isLiked: Bool) {
        detailView.likeButton.setImage(UIImage(systemName: isLiked ?
                                            Resources.SystemImage.like.rawValue :
                                            Resources.SystemImage.unlike.rawValue), for: .normal)
    }
}
