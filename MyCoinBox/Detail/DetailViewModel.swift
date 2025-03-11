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
    let errorMessage = PublishRelay<CustomError>()

    let disposeBag = DisposeBag()
    
    struct Input {
        let id: String
        let likeTap: ControlEvent<Void>
    }
    
    struct Output {
        let result: Driver<[CoinDetail]>
        let errorMessage: PublishRelay<CustomError>
    }
    
    func transform(_ input: Input) -> Output {
        callRequestToNetworkManager(input.id)

        return Output(
            result: result.asDriver(),
            errorMessage: errorMessage
        )
    }
    
    private func fetchDetailData(_ query: String) {
        print(#function)
        NetworkMonitor.shared.getCurrentStatus {  [weak self] status in
            switch status {
            case .satisfied:
                self?.callRequestToNetworkManager(query)
            default:
                print(#function, status)
                break
            }
        }
    }
    
    private func callRequestToNetworkManager(_ ids: String) {
        let api = NetworkRequest.detail(ids: ids)
        NetworkManager.shared.callRequestToAPIServer(api, [CoinDetail].self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.result.accept(data)
            case .failure(let error):
                print(error)
                self?.errorMessage.accept(error)
            }
        }
    }
    
}
