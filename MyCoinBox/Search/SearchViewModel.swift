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
    
    private let resultList = PublishRelay<[Coin]>()
    private let errorMessage = PublishRelay<CustomError>()

    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchClicked: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let resultList: Driver<[Coin]>
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
                    print("no query")
                }
            }
            .disposed(by: disposeBag)

        return Output(
            resultList: resultList.asDriver(onErrorJustReturn: []),
            errorMessage: errorMessage
        )
    }
    
    private func fetchSearchData(_ query: String) {
        NetworkMonitor.shared.getCurrentStatus {  [weak self] status in
            switch status {
            case .satisfied:
                self?.callRequestToNetworkManager(query)
            default:
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
                self?.errorMessage.accept(error)
            }
        }
    }
    
}
