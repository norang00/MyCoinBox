//
//  SearchViewController.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Toast

final class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    let searchViewModel = SearchViewModel()
    
    let dbManager = DBManager()
    var likedList: Results<LikedItem>!

    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.collectionView.showsVerticalScrollIndicator = false
        searchView.collectionView.register(SearchCoinCell.self, forCellWithReuseIdentifier: SearchCoinCell.identifier)
        
        dbManager.getFileURL()
        
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchView.collectionView.reloadData()
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
                    var isLiked = self.checkIsLiked(item)
                    cell.configureData(item, isLiked)
                    cell.onLikeButtonTapped = { [weak self] in
                        guard let self = self else { return }
                        if isLiked {
                            self.dbManager.deleteLikedItem(coinId: item.id)
                            self.searchView.makeToast("\(item.name)이 즐겨찾기에서 제거되었습니다.", duration: 1.0)
                        } else {
                            self.dbManager.createLikedItem(coinId: item.id)
                            self.searchView.makeToast("\(item.name)이 즐겨찾기되었습니다.", duration: 1.0)
                        }
                        isLiked.toggle()
                        cell.configureData(item, isLiked)
                    }
                }
                .disposed(by: disposeBag)
        
        searchView.collectionView.rx.modelSelected(SearchCoin.self)
            .subscribe(with: self) { owner, item in
                let nextVC = DetailViewController()
                nextVC.id = item.id
                owner.navigationController?.pushViewController(nextVC, animated: true)
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
    
    private func checkIsLiked(_ item: SearchCoin) -> Bool {
        likedList = dbManager.getLikedItem()
        let result = likedList.where { $0.coinId == item.id }
        return !result.isEmpty
    }
}
