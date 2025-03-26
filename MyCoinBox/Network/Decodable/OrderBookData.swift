//
//  OrderBookData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/27/25.
//

import Foundation

struct OrderBookData: Decodable {
    let type: String
    let code: String
    let timestamp: Int
    let totalAskSize: Double
    let totalBidSize: Double
    let orderbookUnits: [OrderBookUnit]

    enum CodingKeys: String, CodingKey {
        case type, code, timestamp
        case totalAskSize = "total_ask_size"
        case totalBidSize = "total_bid_size"
        case orderbookUnits = "orderbook_units"
    }
}

struct OrderBookUnit: Decodable {
    let askPrice: Double
    let bidPrice: Double
    let askSize: Double
    let bidSize: Double

    enum CodingKeys: String, CodingKey {
        case askPrice = "ask_price"
        case bidPrice = "bid_price"
        case askSize = "ask_size"
        case bidSize = "bid_size"
    }
}

 /* 예시
  {
    "type": "orderbook",
    "code": "KRW-BTC",
    "timestamp": 1700000000000,
    "total_ask_size": 12.345,
    "total_bid_size": 10.987,
    "orderbook_units": [
      {
        "ask_price": 10000.0,
        "bid_price": 9900.0,
        "ask_size": 1.5,
        "bid_size": 0.7
      },
      ...
    ]
  }
 */

