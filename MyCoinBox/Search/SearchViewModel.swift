//
//  SearchViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/9/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    
    let resultList = PublishRelay<[SearchCoin]>()
    let errorMessage = PublishRelay<CustomError>()

    let disposeBag = DisposeBag()
    
    struct Input {
        let searchClicked: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let resultList: Driver<[SearchCoin]>
        let errorMessage: PublishRelay<CustomError>
    }
    
    func transform(_ input: Input) -> Output {
        
        input.searchClicked
            .startWith(())
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .bind(with: self) { owner, query in
                let value = query.trimmingCharacters(in: .whitespacesAndNewlines)
                if !value.isEmpty {
                    owner.fetchSearchData(query)
                } else {
                    print("검색어가 비어있음")
                }
            }
            .disposed(by: disposeBag)

        return Output(
            resultList: resultList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage
        )
    }
    
    private func fetchSearchData(_ query: String) {
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
    
    private func callRequestToNetworkManager(_ query: String) {
        let api = NetworkRequest.search(query: query)
        NetworkManager.shared.callRequestToAPIServer(api, SearchData.self) { [weak self] response in
            switch response {
            case .success(let data):
                self?.resultList.accept(data.coins)
            case .failure(let error):
                print(error)
                self?.errorMessage.accept(error)
            }
        }
    }
    
}
