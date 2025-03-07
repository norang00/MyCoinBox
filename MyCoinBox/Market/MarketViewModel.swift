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
    
//    var items = []
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let currentTap: Observable<SortStatus>
        let changeTap: Observable<SortStatus>
        let priceTap: Observable<SortStatus>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        
        //[TODO] Observable.merge
        input.currentTap
            .subscribe(with: self) { owner, value in
                print(#function, "currentTap" ,value)
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
            
        )
    }
    
}
