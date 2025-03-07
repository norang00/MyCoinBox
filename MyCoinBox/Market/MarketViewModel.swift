//
//  MarketViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

final class MarketViewModel: BaseViewModel {
    
//    var list = mockMarketData
    var list: [MarketData] = []
    var sort: SortStatus?
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let currentTap: Observable<SortStatus>
        let changeTap: Observable<SortStatus>
        let priceTap: Observable<SortStatus>
    }
    
    struct Output {
        let resultList: BehaviorRelay<[MarketData]>
    }
    
    func transform(_ input: Input) -> Output {
        let resultList = BehaviorRelay(value: list)
        
        //[TODO] Observable.merge
        input.currentTap
            .debug("currentTap")
            .withUnretained(self)
            .flatMap { owner, value in
                owner.sort = value
                return owner.callRequestToNetworkManager()
            }
            .subscribe { value in
                var sorted: [MarketData] = []
                switch self.sort {
                case .deselect, .descending:
                    sorted = value.sorted { $1.trade_price < $0.trade_price }
                case .ascending:
                    sorted = value.sorted { $0.trade_price < $1.trade_price }
                case .none:
                    sorted = []
                }
                resultList.accept(sorted)
            }
            .disposed(by: disposeBag)
        
        input.changeTap
            .debug("changeTap")
            .withUnretained(self)
            .flatMap { owner, value in
                owner.sort = value
                return owner.callRequestToNetworkManager()
            }
            .subscribe { value in
                var sorted: [MarketData] = []
                switch self.sort {
                case .deselect, .descending:
                    sorted = value.sorted { $1.signed_change_rate < $0.signed_change_rate }
                case .ascending:
                    sorted = value.sorted { $0.signed_change_rate < $1.signed_change_rate }
                case .none:
                    sorted = []
                }
                resultList.accept(sorted)
            }
            .disposed(by: disposeBag)
        
        input.priceTap
            .debug("priceTap")
            .withUnretained(self)
            .flatMap { owner, value in
                owner.sort = value
                return owner.callRequestToNetworkManager()
            }
            .subscribe { value in
                var sorted: [MarketData] = []
                switch self.sort {
                case .deselect, .descending:
                    sorted = value.sorted { $1.acc_trade_price_24h < $0.acc_trade_price_24h }
                case .ascending:
                    sorted = value.sorted { $0.acc_trade_price_24h < $1.acc_trade_price_24h }
                case .none:
                    sorted = []
                }
                resultList.accept(sorted)
            }
            .disposed(by: disposeBag)
        
        return Output(
            resultList: resultList
        )
    }
    
    private func callRequestToNetworkManager() -> Single<[MarketData]> {
        return Single<[MarketData]>.create { value in
            let api = NetworkRequest.market
            NetworkManager.shared.callRequestToAPIServer(api, [MarketData].self) { response in
                switch response {
                case .success(let data):
                    value(.success(data))
                case .failure(let error):
                    value(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
