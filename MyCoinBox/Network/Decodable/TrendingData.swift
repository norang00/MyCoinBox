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
}

// MockData
let mockTrendingData = TrendingData(coins: [], nfts: [])
let mockCoinItem = [
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    ))),
    TrendingCoin(item: TrendingCoinItem(
    id: "pixels",
    name: "Pixels",
    symbol: "PIXEL",
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    score: 0,
    data: TrendingCoinData(
        priceChangePercentage24h: [
            "krw": 13.976150617807855
        ]
    )))
    ]
let mockNFTItem = [
    TrendingNFT(
    id: "arc-stellars",
    name: "ARCStellars",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    data: TrendingNFTData(
        floorPrice: "69.00 ETH",
        floorPriceInUsd24hPercentageChange: "234.24743098032"
    )),
    TrendingNFT(
    id: "arc-stellars",
    name: "ARCStellars",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    data: TrendingNFTData(
        floorPrice: "69.00 ETH",
        floorPriceInUsd24hPercentageChange: "234.24743098032"
    )),
    TrendingNFT(
    id: "arc-stellars",
    name: "ARCStellars",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    data: TrendingNFTData(
        floorPrice: "69.00 ETH",
        floorPriceInUsd24hPercentageChange: "234.24743098032"
    )),
    TrendingNFT(
        id: "arc-stellars",
        name: "ARCStellars",
        thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
        data: TrendingNFTData(
            floorPrice: "69.00 ETH",
            floorPriceInUsd24hPercentageChange: "234.24743098032"
        )),
    TrendingNFT(
    id: "arc-stellars",
    name: "ARCStellars",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    data: TrendingNFTData(
        floorPrice: "69.00 ETH",
        floorPriceInUsd24hPercentageChange: "234.24743098032"
    )),
    TrendingNFT(
    id: "arc-stellars",
    name: "ARCStellars",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    data: TrendingNFTData(
        floorPrice: "69.00 ETH",
        floorPriceInUsd24hPercentageChange: "234.24743098032"
    )),
    TrendingNFT(
    id: "arc-stellars",
    name: "ARCStellars",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    data: TrendingNFTData(
        floorPrice: "69.00 ETH",
        floorPriceInUsd24hPercentageChange: "234.24743098032"
    ))
    ]

