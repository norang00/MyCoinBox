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
    
    //    let resultData: BehaviorRelay<TrendingData> = BehaviorRelay(value: mockTrendingData)
    
    let resultData: BehaviorRelay<[TrendingSectionModel]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()
    
    struct Input {
    }
    
    struct Output {
        let resultData: BehaviorRelay<[TrendingSectionModel]>
    }
    
    func transform(_ input: Input) -> Output {
        
        return Output(
            resultData: resultData
        )
    }
    
    func startTimer() {
        fetchTrendingData()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                     selector: #selector(fetchTrendingData), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc
    private func fetchTrendingData() {
        print(#function)
        // [TODO] 인터넷 연결 상태 점검 checkNetworkConnection()
        callRequestToNetworkManager()
    }
    
    private func callRequestToNetworkManager() {
        let api = NetworkRequest.market
        NetworkManager.shared.callRequestToAPIServer(api, TrendingData.self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.convertData(data)
                //                self?.resultData.accept(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func convertData(_ data: TrendingData) {
        let result: [TrendingSectionModel]
        let coinSection = TrendingSectionModel(section: .coin,
                                               headerTitle: Resources.Writing.trendingKeyword.rawValue,
                                               items: data.coins.prefix(14).map { .coin($0) })
        let nftSection = TrendingSectionModel(section: .nft,
                                              headerTitle: Resources.Writing.trendingNFT.rawValue,
                                              items: data.nfts.prefix(7).map { .nft($0) })
        resultData.accept([coinSection, nftSection])
    }
}
