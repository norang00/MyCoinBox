//
//  OrderBookViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/27/25.
//

import RxSwift
import RxCocoa
import RealmSwift

final class OrderBookViewModel {
    
    private let orderbookList = BehaviorRelay<[OrderBookUnit]>(value: [])
    private let disposeBag = DisposeBag()

    struct Input {
        let viewDidLoadTrigger: PublishRelay<Void>
    }

    struct Output {
        let resultList: Driver<[OrderBookUnit]>
    }

    func transform(input: Input) -> Output {
        input.viewDidLoadTrigger
            .bind(with: self) { owner, _ in
                owner.bindWebSocket()
            }
            .disposed(by: disposeBag)

        return Output(resultList: orderbookList.asDriver(onErrorJustReturn: []))
    }
    
    func bindWebSocket() {
        WebSocketManager.shared.onReceiveOrderBook = { [weak self] orderbook in
            let mapped = orderbook.orderbookUnits.map {
                OrderBookUnit(
                    askPrice: $0.askPrice,
                    bidPrice: $0.bidPrice,
                    askSize: $0.askSize,
                    bidSize: $0.bidSize
                )
            }
            self?.orderbookList.accept(mapped)
        }
        
        WebSocketManager.shared.connect()
    }
}
