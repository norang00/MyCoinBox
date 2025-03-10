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
                    
                    var isLiked = self.checkIsLiked(item)
                    cell.configureData(item, isLiked)
                    
                    // Like Button                    
                    cell.likeButton.rx.tap
                        .debug("likeButton.rx.tap")
                        .bind { [weak self] _ in
                            print("likeButton", isLiked)
                            if isLiked {
                                // 좋아요 목록에 있음 isLiked = true -> false 로 바꿔줌 => Delete
                                isLiked.toggle()
                                self?.dbManager.deleteLikedItem(coinId: item.id)
                            } else {
                                // 좋아요 목록에 없음 isLiked = false -> true 로 바꿔줌 => Create
                                isLiked.toggle()
                                self?.dbManager.createLikedItem(coinId: item.id)
                            }
                        }
                        .disposed(by: cell.disposeBag)
                    
                }
                .disposed(by: disposeBag)
        
        searchView.collectionView.rx.modelSelected(SearchCoin.self)
            .debug("collectionView.rx.modelSelected")
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
