//
//  TrendingData.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import Foundation

struct TrendingData: Decodable {
    let coins: [TrendingCoin]
    let nfts: [TrendingNFT]
}

// Coin
struct TrendingCoin: Decodable {
  let item: TrendingCoinItem
}

struct TrendingCoinItem: Decodable {
  let id: String
  let name: String
  let symbol: String
  let thumb: String
  let score: Int
  let data: TrendingCoinData
}

struct TrendingCoinData: Decodable {
  let priceChangePercentage24h: [String: Double] // krw
    
    enum CodingKeys: String, CodingKey {
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

// NFT
struct TrendingNFT: Decodable {
  let id: String
  let name: String // 표시할 데이터
  let thumb: String
  let data: TrendingNFTData
}

struct TrendingNFTData: Decodable {
  let floorPrice: String
  let floorPriceInUsd24hPercentageChange: String
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24hPercentageChange = "floor_price_in_usd_24h_percentage_change"
    }
}
