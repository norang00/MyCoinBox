//
//  DetailData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/10/25.
//

import Foundation

struct CoinDetail: Decodable {
  let id: String
  let symbol: String // 심볼
  let name: String
  let image: String // 코인 아이콘 리소스
  let currentPrice: Double // 코인 현재가
  let marketCap: Double // 시가총액
  let fullyDilutedValuation: Double? // 완전 희석 가치
  let totalVolume: Double // 총 거래량
  let high24h: Double? // 코인 24시간 고가
  let low24h: Double? // 코인 24시간 저가
  let priceChangePercentage24h: Double? // 코인 변동폭
  let ath: Double // 역대 최고가
  let athDate: String // 역대 최고가 일자
  let atl: Double // 역대 최저가
  let atlDate: String // 역대 최저가 일자
  let lastUpdated: String // 최근 업데이트 시간
  let sparklineIn7d: SparklineData? // 시세 정보

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case ath
        case athDate = "ath_date"
        case atl
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

struct SparklineData: Decodable {
  let price: [Double]
}
