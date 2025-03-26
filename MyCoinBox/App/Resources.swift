//
//  Resources.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import Foundation

enum Resources {
    
    enum ButtonTitle: String {
        case current = "현재가"
        case change = "전일대비"
        case price = "거래대금"
    }
    
    enum Writing: String {
        case placeholder = "검색어를 입력해주세요."
        case trendingKeyword = "인기 검색어"
        case trendingNFT = "인기 NFT"
        
        case coin = "코인"
        case nft = "NFT"
        case market = "거래소"
        
        case coinInfo = "종목정보"
        case high24 = "24시간 고가"
        case low24 = "24시간 저가"
        case highest = "역대 최고가"
        case lowest = "역대 최저가"
        case investInfo = "투자지표"
        case marketCap = "시가총액"
        case fdv = "완전 희석 가치(FDV)"
        case totalVolume = "총 거래량"
        case more = "더보기"
        
        case notAvailable = "준비중입니다."
        
        case confirm = "확인"
    }
    
    enum SystemImage: String {
        case arrowUp = "arrowtriangle.up.fill"
        case arrowDown = "arrowtriangle.down.fill"
        case back = "arrow.left"
        case search = "magnifyingglass"
        case like = "star.fill"
        case unlike = "star"
        case chevronRight = "chevron.right"
        case bitcoin = "bitcoinsign.circle"
    }
    
    enum Tab {
        enum Title: String {
            case orderbook = "호가"
            case market = "거래소"
            case trending = "코인정보"
            case portfolio = "포트폴리오"
        }
        
        enum Image: String {
            case orderbook = "bitcoinsign.circle"
            case market = "chart.line.uptrend.xyaxis"
            case trending = "chart.bar.fill"
            case portfolio = "star"
        }
    }
    
    enum Navigation {
        enum Title: String {
            case orderbook = "호가창"
            case market = "거래소"
            case trending = "가상자산/심볼 검색"
            case portfolio = "관심목록"
        }
    }
    
    enum Alert {
        enum Title: String {
            case emptyInput = "검색어를 입력해주세요"
            case noResult = "검색 결과가 없습니다"
            case warning = "이런! 문제가 발생했어요"
            case tooLongKeyword = "검색어가 너무 길어요"
        }
        
        enum Message: String {
            case noResult = "다른 검색어를 입력해보세요"
            case warning = "관리자에게 문의하세요"
            case tooLongKeyword = "20자 이내로 적어주세요"
        }
    }
    
    enum NoInternet: String {
        case title = "안내"
        case description = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        case retry = "다시 시도하기"
        case toastMessage = "네트워크 통신이 원활하지 않습니다."
    }
}
