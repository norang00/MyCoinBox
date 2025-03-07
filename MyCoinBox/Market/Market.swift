//
//  Market.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import Foundation

struct Market {
  let market: String // 코인
  let tradeDate: String
  let tradeTime: String
  let tradeDateKst: String
  let tradeTimeKst: String
  let tradeTimestamp: Int64
  let openingPrice: Double
  let highPrice: Double
  let lowPrice: Double
  let tradePrice: Double // 현재가
  let prevClosingPrice: Double
  let change: String // 전일대비 상태
  let changePrice: Double
  let changeRate: Double
  let signedChangePrice: Double // 전일대비 금액
  let signedChangeRate: Double // 전일대비 퍼센트
  let tradeVolume: Double
  let accTradePrice: Double
  let accTradePrice24h: Double // 거래대금
  let accTradeVolume: Double
  let accTradeVolume24h: Double
  let highest52WeekPrice: Double
  let highest52WeekDate: String
  let lowest52WeekPrice: Double
  let lowest52WeekDate: String
  let timestamp: Int64
}
