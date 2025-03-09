//
//  SearchData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/9/25.
//

import Foundation

struct SearchData: Decodable {
    let coins: [SearchCoin]
}

struct SearchCoin: Decodable {
  let id: String
  let name: String
  let symbol: String
  let marketCapRank: Int
  let thumb: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
    }
}
