//
//  BaseViewModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import Foundation

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
