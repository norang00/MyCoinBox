//
//  DetailViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/10/25.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: BaseViewModel {
    
    let result: BehaviorRelay<[CoinDetail]> = BehaviorRelay(value: [])

    let disposeBag = DisposeBag()
    
    struct Input {
        let id: String
        let likeTap: ControlEvent<Void>
    }
    
    struct Output {
        let result: Driver<[CoinDetail]>
    }
    
    func transform(_ input: Input) -> Output {
        callRequestToNetworkManager(input.id)

        return Output(
            result: result.asDriver()
        )
    }
    
    private func fetchDetailData(_ query: String) {
        print(#function)
        // [TODO] 인터넷 연결 상태 점검 checkNetworkConnection()
        callRequestToNetworkManager(query)
    }
    
    private func callRequestToNetworkManager(_ ids: String) {
        let api = NetworkRequest.detail(ids: ids)
        NetworkManager.shared.callRequestToAPIServer(api, [CoinDetail].self) { [weak self] response in
            switch response {
            case .success(let data):
                dump(data)
                self?.result.accept(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
