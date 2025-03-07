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
            .flatMap { owner, _ in
                owner.callRequestToNetworkManager()
            }
            .subscribe { value in
                resultList.accept(value)
            }
            .disposed(by: disposeBag)
        
        input.changeTap
            .subscribe(with: self) { owner, value in
                print(#function, "currentTap" ,value)
            }
            .disposed(by: disposeBag)
        
        input.priceTap
            .subscribe(with: self) { owner, value in
                print(#function, "currentTap" ,value)
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
