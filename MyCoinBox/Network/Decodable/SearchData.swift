//
//  SearchData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/9/25.
//

import Foundation

struct SearchData: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable {
  var id: String
  var name: String
  var symbol: String
  var marketCapRank: Int?
  var thumb: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
    }
}
