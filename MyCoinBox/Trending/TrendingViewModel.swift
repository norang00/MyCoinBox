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
    
    let coinData: BehaviorRelay<[TrendingCoin]> = BehaviorRelay(value: [])
    let nftData: BehaviorRelay<[TrendingNFT]> = BehaviorRelay(value: [])

    let disposeBag = DisposeBag()
    
    struct Input {
    }
    
    struct Output {
        let coinData: Driver<[TrendingCoin]>
        let nftData: Driver<[TrendingNFT]>
    }
    
    func transform(_ input: Input) -> Output {
        startTimer()
        
        return Output(
            coinData: coinData.asDriver(),
            nftData: nftData.asDriver()
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
        // [TODO] 인터넷 연결 상태 점검 checkNetworkConnection()
        callRequestToNetworkManager()
    }
    
    private func callRequestToNetworkManager() {
        let api = NetworkRequest.trending
        NetworkManager.shared.callRequestToAPIServer(api, TrendingData.self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.convertData(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func convertData(_ data: TrendingData) {
        let coins = Array(data.coins.prefix(14))
        let nfts = Array(data.nfts.prefix(7))
        coinData.accept(coins)
        nftData.accept(nfts)
    }
}
