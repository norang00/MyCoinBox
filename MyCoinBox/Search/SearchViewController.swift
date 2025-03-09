//
//  SearchViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    let searchViewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.collectionView.showsVerticalScrollIndicator = false
        searchView.collectionView.register(SearchCoinCell.self, forCellWithReuseIdentifier: SearchCoinCell.identifier)

        
        bind()
    }
    
    private func bind() {
        let input = SearchViewModel.Input(
            searchClicked: searchView.searchBar.rx.searchButtonClicked,
            searchText: searchView.searchBar.rx.text.orEmpty
        )
        let output = searchViewModel.transform(input)
        
        output.resultList
            .drive(searchView.collectionView.rx.items(
                cellIdentifier: SearchCoinCell.identifier,
                cellType: SearchCoinCell.self)) { index, item, cell in
                    cell.configureData(item)
                }
                .disposed(by: disposeBag)
        
        searchView.backButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.popToTrendingView()
            }
            .disposed(by: disposeBag)

        
    }
    
    private func popToTrendingView() {
        navigationController?.popViewController(animated: true)
    }
}
