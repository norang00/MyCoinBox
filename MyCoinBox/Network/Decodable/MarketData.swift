//
//  MarketData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import Foundation

struct MarketData: Decodable {
  let market: String // 코인
  let tradePrice: Double // 현재가
  let change: String // 전일대비 상태
  let signedChangePrice: Double // 전일대비 금액
  let signedChangeRate: Double // 전일대비 퍼센트
  let accTradePrice24h: Double // 거래대금

    enum CodingKeys: String, CodingKey {
        case market
        case tradePrice = "trade_price"
        case change
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
        case accTradePrice24h = "acc_trade_price_24h"
    }
}
