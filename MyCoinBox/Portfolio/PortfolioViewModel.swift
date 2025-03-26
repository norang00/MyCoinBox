//
//  PortfolioViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/26/25.
//

import RxSwift
import RxCocoa
import RealmSwift

final class PortfolioViewModel {

    private let dbManager = DBManager.shared
    
    private let resultList = PublishRelay<[LikedCoin]>()
    private let disposeBag = DisposeBag()

    struct Input {
        let viewDidLoadTrigger: PublishRelay<Void>
    }

    struct Output {
        let likedList: Driver<[LikedCoin]>
    }

    func transform(input: Input) -> Output {
        print(#function)
        input.viewDidLoadTrigger
            .bind(with: self) { owner, _ in
                let list = owner.dbManager.getLikedItem()
                print("💡 좋아요 목록:", list.count)
                owner.resultList.accept(Array(list))
            }
            .disposed(by: disposeBag)

        return Output(likedList: resultList.asDriver(onErrorJustReturn: []))
    }
}
