//
//  MarketViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MarketViewModel: BaseViewModel {
    
    var timer = Timer()
    
    var list: [MarketData] = [] {
        didSet {
            resultList.accept(list)
        }
    }
    var sortWith: SortValue = .price
    var sortBy: SortStatus = .descending
    
    let resultList = PublishRelay<[MarketData]>()
    let errorMessage = PublishRelay<CustomError>()

    let disposeBag = DisposeBag()
    
    struct Input {
        let currentTap: Observable<SortStatus>
        let changeTap: Observable<SortStatus>
        let priceTap: Observable<SortStatus>
    }
    
    struct Output {
        let resultList: Driver<[MarketData]>
        let errorMessage: PublishRelay<CustomError>
    }

    func transform(_ input: Input) -> Output {

        let buttons = [
            input.currentTap.map { sortStatus in (SortValue.current, sortStatus) },
            input.changeTap.map { sortStatus in (SortValue.change, sortStatus) },
            input.priceTap.map { sortStatus in (SortValue.price, sortStatus) }
        ]
        
        Observable.merge(buttons)
            .withUnretained(self)
            .do { owner, value in
                owner.sortWith = value.0
                owner.sortBy = value.1
                owner.sortList(owner.list)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return Output(
            resultList: resultList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage
        )
    }
    
    func startTimer() {
        fetchMarketData()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                             selector: #selector(fetchMarketData), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc
    private func fetchMarketData() {
        NetworkMonitor.shared.getCurrentStatus {  [weak self] status in
            switch status {
            case .satisfied:
                self?.callRequestToNetworkManager()
            default:
                break
            }
        }
    }
    
    private func callRequestToNetworkManager() {
        let api = NetworkRequest.market
        NetworkManager.shared.callRequestToAPIServer(api, [MarketData].self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.sortList(data)
            case .failure(let error):
                self?.errorMessage.accept(error)
            }
        }
    }
    
    private func sortList(_ data: [MarketData]) {
        list = data.sorted(by: getSortCriteria())
    }

    private func getSortCriteria() -> (MarketData, MarketData) -> Bool {
        switch (sortWith, sortBy) {
        case (_, .deselect):
            sortWith = .price
            return { $1.accTradePrice24h < $0.accTradePrice24h }
        case (.current, .descending):
            return { $1.tradePrice < $0.tradePrice }
        case (.current, .ascending):
            return { $0.tradePrice < $1.tradePrice }
        case (.change, .descending):
            return { $1.signedChangeRate < $0.signedChangeRate }
        case (.change, .ascending):
            return { $0.signedChangeRate < $1.signedChangeRate }
        case (.price, .descending):
            return { $1.accTradePrice24h < $0.accTradePrice24h }
        case (.price, .ascending):
            return { $0.accTradePrice24h < $1.accTradePrice24h }
        }
    }
    
//    private func sortList(_ data: [MarketData]) {
//        var sorted: [MarketData] = []
//        switch sortWith {
//        case .current:
//            switch sortBy {
//            case .deselect:
//                sortWith = .price
//                sorted = data.sorted { $1.accTradePrice24h < $0.accTradePrice24h }
//            case .descending:
//                sorted = data.sorted { $1.tradePrice < $0.tradePrice }
//            case .ascending:
//                sorted = data.sorted { $0.tradePrice < $1.tradePrice }
//            }
//        case .change:
//            switch sortBy {
//            case .deselect:
//                sortWith = .price
//                sorted = data.sorted { $1.accTradePrice24h < $0.accTradePrice24h }
//            case .descending:
//                sorted = data.sorted { $1.signedChangeRate < $0.signedChangeRate }
//            case .ascending:
//                sorted = data.sorted { $0.signedChangeRate < $1.signedChangeRate }
//            }
//        case .price:
//            switch sortBy {
//            case .deselect, .descending:
//                sorted = data.sorted { $1.accTradePrice24h < $0.accTradePrice24h }
//            case .ascending:
//                sorted = data.sorted { $0.accTradePrice24h < $1.accTradePrice24h }
//            }
//        }
//        list = sorted
//    }
}
