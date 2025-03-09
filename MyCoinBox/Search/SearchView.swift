//
//  SearchView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
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

        initTabButtons()
        configureSwipeGesture()
    }

    private func initTabButtons() {
        coinTabButton.isSelected = true
        coinTabButton.tag = 0
        coinTabButton.addTarget(self, action: #selector(TabButtonTapped), for: .touchUpInside)
        
        nftTabButton.isSelected = false
        nftTabButton.tag = 1
        nftTabButton.addTarget(self, action: #selector(TabButtonTapped), for: .touchUpInside)

        marketTabButton.isSelected = false
        marketTabButton.tag = 2
        marketTabButton.addTarget(self, action: #selector(TabButtonTapped), for: .touchUpInside)
    }
    
    private func configureSwipeGesture() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized(_:)))
        leftSwipe.direction = .left
        addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized(_:)))
        rightSwipe.direction = .right
        addGestureRecognizer(rightSwipe)
    }
    
    @objc
    private func TabButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        switchTabTo(index)
    }
    
    @objc
    private func swipeRecognized(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            if currentIndex < 2 { switchTabTo(currentIndex+1) }
        case .right:
            if currentIndex > 0 { switchTabTo(currentIndex-1) }
        default:
            switchTabTo(currentIndex)
        }
    }
    
    private func switchTabTo(_ index: Int) {
        tabButtons.forEach { $0.isSelected = false }
        tabButtons[index].isSelected = true
        currentIndex = index
        
        switch index {
        case 0:
            collectionView.isHidden = false
            emptyView.isHidden = true
        case 1, 2:
            collectionView.isHidden = true
            emptyView.isHidden = false
        default:
            collectionView.isHidden = true
            emptyView.isHidden = true
        }
    }
}
