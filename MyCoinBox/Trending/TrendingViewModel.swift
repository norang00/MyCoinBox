//
//  TrendingViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendingViewModel: BaseViewModel {
    
    var timer = Timer()
    
    let update: BehaviorRelay<Date> = BehaviorRelay(value: Date())
    let coinData: BehaviorRelay<[TrendingCoin]> = BehaviorRelay(value: [])
    let nftData: BehaviorRelay<[TrendingNFT]> = BehaviorRelay(value: [])
    let errorMessage = PublishRelay<CustomError>()

    let disposeBag = DisposeBag()
    
    struct Input {
    }
    
    struct Output {
        let update: BehaviorRelay<Date>
        let coinData: Driver<[TrendingCoin]>
        let nftData: Driver<[TrendingNFT]>
        let errorMessage: PublishRelay<CustomError>
    }
    
    func transform(_ input: Input) -> Output {
        startTimer()
        
        return Output(
            update: update,
            coinData: coinData.asDriver(),
            nftData: nftData.asDriver(),
            errorMessage: errorMessage
        )
    }
    
    func startTimer() {
        fetchTrendingData()
        timer = Timer.scheduledTimer(timeInterval: 600, target: self,
                                     selector: #selector(fetchTrendingData), userInfo: nil, repeats: true)
    }
    
    @objc
    private func fetchTrendingData() {
        print(#function)
        NetworkMonitor.shared.getCurrentStatus {  [weak self] status in
            switch status {
            case .satisfied:
                self?.callRequestToNetworkManager()
            default:
                print(#function, status)
                break
            }
        }
    }
    
    private func callRequestToNetworkManager() {
        let api = NetworkRequest.trending
        NetworkManager.shared.callRequestToAPIServer(api, TrendingData.self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.convertData(data)
            case .failure(let error):
                print(error)
                self?.errorMessage.accept(error)
            }
        }
    }
    
    private func convertData(_ data: TrendingData) {
        let date = Date()
        let coins = Array(data.coins.prefix(14))
        let nfts = Array(data.nfts.prefix(7))
        update.accept(date)
        coinData.accept(coins)
        nftData.accept(nfts)
    }
}
