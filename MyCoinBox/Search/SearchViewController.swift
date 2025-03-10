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
//                    let resultRelay = BehaviorRelay(value: isLiked)
                    
                    cell.likeButton.rx.tap
                        .debug("like tap")
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
//                            resultRelay.accept(isLiked)
                        }
                        .disposed(by: cell.disposeBag)
                    
//                    resultRelay.asDriver()
//                        .drive(with: self) { owner, result in
//                            let likeImage = UIImage(named: isLiked ?
//                                                    Resources.SystemImage.like.rawValue :
//                                                    Resources.SystemImage.unlike.rawValue)
//                            cell.likeButton.setImage(likeImage, for: .normal)
//                        }
//                        .disposed(by: self.disposeBag)
                }
                .disposed(by: disposeBag)
        
        
        //                                resultRelay.accept(!resultRelay.value)
        //                            }
        //                        } catch {
        //                            print("Realm 저장 오류:", error)
        //                        }
        //                    }
        //                    .disposed(by: cell.disposeBag)  // ✅ 셀마다 개별 disposeBag 사용
        //
        //                // 4️⃣ 좋아요 버튼 UI 업데이트
        //                resultRelay.asDriver()
        //                    .drive { isLiked in
        //                        let likeImage = UIImage(named: isLiked ?
        //                            Resources.SystemImage.like.rawValue :
        //                            Resources.SystemImage.unlike.rawValue)
        //                        cell.likeButton.setImage(likeImage, for: .normal)
        //                    }
        //                    .disposed(by: cell.disposeBag)  // ✅ 셀마다 개별 disposeBag 사용
        //            }
        //            .disposed(by: disposeBag)
        
        //        output.resultList
        //            .drive(searchView.collectionView.rx.items(
        //                cellIdentifier: SearchCoinCell.identifier,
        //                cellType: SearchCoinCell.self)) { [weak self] index, item, cell in
        //                    var isLiked = self?.checkIsLiked(item)
        //                    cell.configureData(item, isLiked!)
        //
        //                    // Like Button
        //                    //-------------------------------
        //                    let resultRelay = BehaviorRelay(value: false)
        //                    cell.likeButton.rx.tap.bind { [weak self] _ in
        //                        print("isLiked", isLiked)
        //                        isLiked.toggle()
        //                        print("isLiked", isLiked)
        //                        do {
        //                            try self?.realm.write {
        //                                if isLiked {
        //                                    let data = LikedItem(coinId: item.id)
        //                                    print("data", data)
        //                                    self?.realm.add(data)
        //                                    resultRelay.accept(true)
        //
        //                                    var style = ToastStyle()
        //                                    style.shadowColor = .white
        //                                    style.messageColor = .white
        //                                    self?.resultView.makeToast("좋아요 목록에 추가!", duration: 1.0, style: style)
        //
        //                                } else {
        //                                    let data = self?.realm.objects(LikedItem.self).where { $0.coinId == item.id }
        //                                    self?.realm.delete(data!)
        //                                    resultRelay.accept(false)
        //                                }
        //                            }
        //                        } catch {
        //                            print(error)
        //                        }
        //                    }
        //                    .disposed(by: self.disposeBag)
        //
        //                    resultRelay.asDriver().drive { [weak self] _ in
        //                        let likeImage = UIImage(named: isLiked ?
        //                                                Resources.SystemImage.like.rawValue
        //                                                : Resources.SystemImage.unlike.rawValue)
        //                        cell.likeButton.setImage(likeImage, for: .normal)
        //                    }
        //                    .disposed(by: self.disposeBag)
        //                    //-------------------------------
        //
        //                }
        //                .disposed(by: disposeBag)
        
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
