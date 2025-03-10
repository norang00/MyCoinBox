//
//  DetailView.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import DGCharts

final class DetailView: BaseView {
    private var disposeBag = DisposeBag()

    private let navigationBar = UIStackView()
    let backButton = UIButton()
    private let iconStackView = UIStackView()
    let iconImageView = UIImageView()
    let coinSymbolLabel = UILabel()
    let likeButton = UIButton()
    private let borderView = UIView()

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let currentPriceLabel = UILabel()
    let changePercentLabel = UILabel()
    let changeChart = LineChartView()
    let updateLabel = UILabel()
    
    private let coinInfoTitleStack = UIStackView()
    let coinInfoTitleLabel = UILabel()
    let coinInfoShowMoreButton = UIButton()
    
    private let coinInfoRoundedBackground = UIView()
    private let coinInfoStackView = UIStackView()

    private let price24StackView = UIStackView()
    private let high24hStackView = UIStackView()
    private let high24hTitleLabel = UILabel()
    let high24hValueLabel = UILabel()
    private let low24hStackView = UIStackView()
    private let low24hTitleLabel = UILabel()
    let low24hValueLabel = UILabel()

    private let priceStackView = UIStackView()
    private let highestStackView = UIStackView()
    private let highestTitleLabel = UILabel()
    let highestValueLabel = UILabel()
    let highestDateLabel = UILabel()
    private let lowestStackView = UIStackView()
    private let lowestTitleLabel = UILabel()
    let lowestValueLabel = UILabel()
    let lowestDateLabel = UILabel()

    private let investTitleStack = UIStackView()
    let investTitleLabel = UILabel()
    let investShowMoreButton = UIButton()
    
    private let investRoundedBackground = UIView()
    private let investInfoStackView = UIStackView()
    
    private let marketCapStackView = UIStackView()
    private let marketCapTitleLabel = UILabel()
    let marketCapValueLabel = UILabel()
    
    private let fdvStackView = UIStackView()
    private let fdvTitleLabel = UILabel()
    let fdvValueLabel = UILabel()

    private let totalVolumeStackView = UIStackView()
    private let totalVolumeTitleLabel = UILabel()
    let totalVolumeValueLabel = UILabel()

    override func configureHierarchy() {
        //navigation
        [navigationBar, borderView]
            .forEach { addSubview($0) }
        [backButton, iconStackView, likeButton]
            .forEach { navigationBar.addArrangedSubview($0) }
        [iconImageView, coinSymbolLabel]
            .forEach { iconStackView.addArrangedSubview($0) }

        //background
        [scrollView]
            .forEach { addSubview($0) }
        [contentView]
            .forEach { scrollView.addSubview($0) }
        
        //차트
        [currentPriceLabel, changePercentLabel, changeChart, updateLabel]
            .forEach { contentView.addSubview($0) }
        
        //종목정보
        [coinInfoTitleStack]
            .forEach { contentView.addSubview($0) }
        [coinInfoTitleLabel, coinInfoShowMoreButton]
            .forEach { coinInfoTitleStack.addArrangedSubview($0) }
        
        [coinInfoRoundedBackground]
            .forEach { contentView.addSubview($0) }
        [coinInfoStackView]
            .forEach { coinInfoRoundedBackground.addSubview($0) }
        [price24StackView, priceStackView]
            .forEach { coinInfoStackView.addArrangedSubview($0) }
        [high24hStackView, low24hStackView]
            .forEach { price24StackView.addArrangedSubview($0) }
        [high24hTitleLabel, high24hValueLabel]
            .forEach { high24hStackView.addArrangedSubview($0) }
        [low24hTitleLabel, low24hValueLabel]
            .forEach { low24hStackView.addArrangedSubview($0) }
        [highestStackView, lowestStackView]
            .forEach { priceStackView.addArrangedSubview($0) }
        [highestTitleLabel, highestValueLabel, highestDateLabel]
            .forEach { highestStackView.addArrangedSubview($0) }
        [lowestTitleLabel, lowestValueLabel, lowestDateLabel]
            .forEach { lowestStackView.addArrangedSubview($0) }
        
        //투자지표
        [investTitleStack]
            .forEach { contentView.addSubview($0) }
        [investTitleLabel, investShowMoreButton]
            .forEach { investTitleStack.addArrangedSubview($0) }
        
        [investRoundedBackground]
            .forEach { contentView.addSubview($0) }
        [investInfoStackView]
            .forEach { investRoundedBackground.addSubview($0) }
        [marketCapStackView, fdvStackView, totalVolumeStackView]
            .forEach { investInfoStackView.addArrangedSubview($0) }
        [marketCapTitleLabel, marketCapValueLabel]
            .forEach { marketCapStackView.addArrangedSubview($0) }
        [fdvTitleLabel, fdvValueLabel]
            .forEach { fdvStackView.addArrangedSubview($0) }
        [totalVolumeTitleLabel, totalVolumeValueLabel]
            .forEach { totalVolumeStackView.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        backButton.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        borderView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(investRoundedBackground.snp.bottom).offset(20)
        }
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        changePercentLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        changeChart.snp.makeConstraints { make in
            make.top.equalTo(changePercentLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(200)
        }
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(changeChart.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        
        coinInfoTitleStack.snp.makeConstraints { make in
            make.top.equalTo(updateLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        coinInfoRoundedBackground.snp.makeConstraints { make in
            make.top.equalTo(coinInfoTitleStack.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        coinInfoStackView.snp.makeConstraints { make in
            make.edges.equalTo(coinInfoRoundedBackground).inset(16)
        }
        price24StackView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        priceStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        investTitleStack.snp.makeConstraints { make in
            make.top.equalTo(coinInfoRoundedBackground.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(20)
        }
        investRoundedBackground.snp.makeConstraints { make in
            make.top.equalTo(investTitleStack.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.lessThanOrEqualTo(contentView).inset(20)
        }
        investInfoStackView.snp.makeConstraints { make in
            make.edges.equalTo(investRoundedBackground).inset(16)
        }
    }

    override func configureView() {
        super.configureView()
        
        navigationBar.axis = .horizontal
        navigationBar.distribution = .equalSpacing
        backButton.setImage(UIImage(systemName: Resources.SystemImage.back.rawValue), for: .normal)
        iconStackView.spacing = 8
        
        iconImageView.image = UIImage(systemName: Resources.SystemImage.bitcoin.rawValue)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 15
        
        coinSymbolLabel.text = "BTC"
        coinSymbolLabel.textColor = .mainText
        coinSymbolLabel.font = .systemFont(ofSize: 16, weight: .black)
        likeButton.tintColor = .accent
        likeButton.setImage(UIImage(systemName: Resources.SystemImage.unlike.rawValue), for: .normal)
        likeButton.imageView?.contentMode = .scaleAspectFit
        borderView.backgroundColor = .badgeBg
        
        scrollView.showsVerticalScrollIndicator = false
        
        currentPriceLabel.text = "₩140,375,094"
        currentPriceLabel.textColor = .mainText
        currentPriceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        changePercentLabel.text = "0.00%"
        changePercentLabel.textColor = .mainText
        changePercentLabel.font = .systemFont(ofSize: 14, weight: .bold)

        changeChart.backgroundColor = .lightGray
        
        updateLabel.text = "2/15 18:00:45 업데이트"
        updateLabel.textColor = .subText
        updateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        
        coinInfoTitleStack.axis = .horizontal
        coinInfoTitleStack.distribution = .equalSpacing
        
        coinInfoTitleLabel.text = "종목정보"
        coinInfoTitleLabel.textColor = .mainText
        coinInfoTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        coinInfoShowMoreButton.setTitle("더보기", for: .normal)
        coinInfoShowMoreButton.setTitleColor(.subText, for: .normal)
        coinInfoShowMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        coinInfoShowMoreButton.semanticContentAttribute = .forceRightToLeft
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let resizedImage = UIImage(systemName: Resources.SystemImage.chevronRight.rawValue, withConfiguration: config)
        coinInfoShowMoreButton.setImage(resizedImage, for: .normal)
        coinInfoShowMoreButton.tintColor = .subText
        coinInfoShowMoreButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)

        coinInfoRoundedBackground.layer.cornerRadius = 20
        coinInfoRoundedBackground.backgroundColor = .infoBg

        coinInfoStackView.axis = .vertical
        coinInfoStackView.distribution = .fillProportionally
        coinInfoStackView.spacing = 16
        
        price24StackView.axis = .horizontal
        price24StackView.distribution = .fillEqually
        high24hStackView.axis = .vertical
        high24hStackView.distribution = .fillEqually
        high24hStackView.spacing = 2
        low24hStackView.axis = .vertical
        low24hStackView.spacing = 2
        low24hStackView.distribution = .fillEqually

        high24hTitleLabel.text = "24시간 고가"
        high24hTitleLabel.textColor = .subText
        high24hTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        high24hValueLabel.text = "₩142,060,908"
        high24hValueLabel.textColor = .mainText
        high24hValueLabel.font = .systemFont(ofSize: 14, weight: .bold)

        low24hTitleLabel.text = "24시간 저가"
        low24hTitleLabel.textColor = .subText
        low24hTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        low24hValueLabel.text = "₩139,531,878"
        low24hValueLabel.textColor = .mainText
        low24hValueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        priceStackView.axis = .horizontal
        priceStackView.distribution = .fillEqually
        highestStackView.axis = .vertical
        highestStackView.distribution = .fillEqually
        highestStackView.spacing = 2
        lowestStackView.axis = .vertical
        lowestStackView.distribution = .fillEqually
        lowestStackView.spacing = 2
        
        highestTitleLabel.text = "역대 최고가"
        highestTitleLabel.textColor = .subText
        highestTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        highestValueLabel.text = "₩157,802,010"
        highestValueLabel.textColor = .mainText
        highestValueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        highestDateLabel.text = "25년 1월 20일"
        highestDateLabel.textColor = .subText
        highestDateLabel.font = .systemFont(ofSize: 9, weight: .regular)
        
        lowestTitleLabel.text = "역대 최저가"
        lowestTitleLabel.textColor = .subText
        lowestTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        lowestValueLabel.text = "₩75,594"
        lowestValueLabel.textColor = .mainText
        lowestValueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        lowestDateLabel.text = "13년 7월 5일"
        lowestDateLabel.textColor = .subText
        lowestDateLabel.font = .systemFont(ofSize: 9, weight: .regular)
        
        investTitleStack.axis = .horizontal
        investTitleStack.distribution = .equalSpacing
        
        investTitleLabel.text = "투자지표"
        investTitleLabel.textColor = .mainText
        investTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        investShowMoreButton.setTitle("더보기", for: .normal)
        investShowMoreButton.setTitleColor(.subText, for: .normal)
        investShowMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        investShowMoreButton.semanticContentAttribute = .forceRightToLeft
        investShowMoreButton.setImage(resizedImage, for: .normal)
        investShowMoreButton.tintColor = .subText
        investShowMoreButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)

        investRoundedBackground.layer.cornerRadius = 20
        investRoundedBackground.backgroundColor = .infoBg

        investInfoStackView.axis = .vertical
        investInfoStackView.distribution = .fillEqually
        investInfoStackView.spacing = 16
        
        marketCapStackView.axis = .vertical
        marketCapStackView.distribution = .fillEqually
        fdvStackView.axis = .vertical
        fdvStackView.distribution = .fillEqually
        totalVolumeStackView.axis = .vertical
        totalVolumeStackView.distribution = .fillEqually

        marketCapTitleLabel.text = "시가총액"
        marketCapTitleLabel.textColor = .subText
        marketCapTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        marketCapValueLabel.text = "₩2,787,407,213,792,217"
        marketCapValueLabel.textColor = .mainText
        marketCapValueLabel.font = .systemFont(ofSize: 14, weight: .bold)

        fdvTitleLabel.text = "완전 희석 가치(FDV)"
        fdvTitleLabel.textColor = .subText
        fdvTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        fdvValueLabel.text = "₩2,787,407,213,792,217"
        fdvValueLabel.textColor = .mainText
        fdvValueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        totalVolumeTitleLabel.text = "총 거래량"
        totalVolumeTitleLabel.textColor = .subText
        totalVolumeTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        totalVolumeValueLabel.text = "₩2,787,407,213,792,217"
        totalVolumeValueLabel.textColor = .mainText
        totalVolumeValueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        configureChart()
    }
}

// MARK: - Charts
extension DetailView {
    
    private func configureChart() {
        changeChart.backgroundColor = .white

        changeChart.rightAxis.enabled = false
        changeChart.leftAxis.enabled = false
        changeChart.xAxis.enabled = false
        changeChart.legend.enabled = false
        changeChart.animate(xAxisDuration: 2.5)
    }
}
