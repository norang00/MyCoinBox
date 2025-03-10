//
//  SearchView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class SearchView: BaseView {
    private var disposeBag = DisposeBag()
    
    private let navigationBar = UIView()
    let backButton = UIButton()
    let searchBar = UISearchBar()
    private let borderView = UIView()

    var currentIndex = 0
    private let stackView = UIStackView()
    let coinTabButton = TabButton(title: Resources.Writing.coin.rawValue, frame: .zero)
    let nftTabButton = TabButton(title: Resources.Writing.nft.rawValue, frame: .zero)
    let marketTabButton = TabButton(title: Resources.Writing.market.rawValue, frame: .zero)
    lazy var tabButtons: [TabButton] = [coinTabButton, nftTabButton, marketTabButton]
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let emptyView = UIView()
    private let emptyLabel = UILabel()
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(navigationBar)
        navigationBar.addSubview(backButton)
        navigationBar.addSubview(searchBar)
        addSubview(borderView)
        
        addSubview(stackView)
        stackView.addArrangedSubview(coinTabButton)
        stackView.addArrangedSubview(nftTabButton)
        stackView.addArrangedSubview(marketTabButton)

        addSubview(collectionView)
        
        addSubview(emptyView)
        emptyView.addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(26)
        }
        searchBar.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.equalTo(navigationBar)
            make.leading.equalTo(backButton.snp.trailing)
            make.trailing.equalToSuperview().inset(24)
        }
        borderView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(emptyView)
        }
    }

    override func configureView() {
        super.configureView()
        
        backButton.setImage(UIImage(systemName: Resources.SystemImage.back.rawValue), for: .normal)
        let empty = UIImage()
        searchBar.setImage(empty, for: .search, state: .normal)
        searchBar.setBackgroundImage(empty, for: .any, barMetrics: .default)
        searchBar.searchTextField.font = .systemFont(ofSize: 12, weight: .regular)
        searchBar.searchTextField.backgroundColor = .white
        borderView.backgroundColor = .badgeBg
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
                
        emptyLabel.text = Resources.Writing.notAvailable.rawValue
        emptyView.isHidden = true
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        configureTabButtons()
        configureSwipeGesture()
        configureKeyboardDismiss()
    }

    private func configureTabButtons() {
        tabButtons.enumerated().forEach { index, button in
            button.tag = index
            button.rx.tap
                .subscribe(with: self) { owner, _ in
                    owner.switchTabTo(button.tag)
                }
                .disposed(by: disposeBag)
        }
        tabButtons[0].isSelected = true // init
    }
    
    private func configureSwipeGesture() {
        self.rx.swipeGesture(.left) { recognizer, _ in
            recognizer.cancelsTouchesInView = false
        }
        .when(.recognized)
        .subscribe(with: self) { owner, _ in
            if owner.currentIndex < 2 { owner.switchTabTo(owner.currentIndex+1) }
        }
        .disposed(by: disposeBag)
        
        self.rx.swipeGesture(.right) { recognizer, _ in
            recognizer.cancelsTouchesInView = false
        }
        .when(.recognized)
        .subscribe(with: self) { owner, _ in
            if owner.currentIndex > 0 { owner.switchTabTo(owner.currentIndex-1) }
        }
        .disposed(by: disposeBag)
    }
    
    private func switchTabTo(_ index: Int) {
        guard index != currentIndex else { return }

        let direction: CGFloat = (index > currentIndex) ? 1 : -1
        let offset = collectionView.frame.width * direction

        let targetView = (index == 0) ? collectionView : emptyView
        let currentView = (index == 0) ? emptyView : collectionView

        targetView.transform = CGAffineTransform(translationX: offset, y: 0)
        targetView.isHidden = false

        UIView.animate(withDuration: 0.3, animations: {
            targetView.transform = .identity
            currentView.transform = CGAffineTransform(translationX: -offset, y: 0)
        }) { _ in
            currentView.isHidden = true
            currentView.transform = .identity
        }

        tabButtons.forEach { $0.isSelected = false }
        tabButtons[index].isSelected = true
        currentIndex = index
    }
    
    private func configureKeyboardDismiss() {
        self.rx.tapGesture() { recognizer, _ in
            recognizer.cancelsTouchesInView = false
        }
        .when(.recognized)
        .bind(with: self) { owner, _ in
            owner.endEditing(true)
        }
        .disposed(by: disposeBag)
        
        collectionView.rx.swipeGesture(.down, .up) { recognizer, _ in
            recognizer.cancelsTouchesInView = false
        }
        .when(.recognized)
        .bind(with: self) { owner, _ in
            owner.endEditing(true)
        }
        .disposed(by: disposeBag)
    }
}
