//
//  MarketData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import Foundation

struct MarketData: Decodable {
  let market: String // 코인
  let trade_price: Double // 현재가
  let change: String // 전일대비 상태
  let signed_change_price: Double // 전일대비 금액
  let signed_change_rate: Double // 전일대비 퍼센트
  let acc_trade_price_24h: Double // 거래대금
}
