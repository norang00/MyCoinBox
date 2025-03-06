//
//  API.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import Foundation

enum API {
    
    enum URL: String {
        case market = "https://api.upbit.com/v1/ticker/all" //?quote_currencies=KRW
        case trending = "https://api.coingecko.com/api/v3/search/trending"
        case search = "https://api.coingecko.com/api/v3/search" //?query=bitcoin
        case detail = "https://api.coingecko.com/api/v3/coins/markets" //?vs_currency=krw&ids=bitcoin
    }
    
//    [TODO] public 이라 필요없는가 본데? 나중에 지워야지
//    enum Key: String {
//        case detail = "CG-Yaa1gGmdrbzsxtWPHJhiVjTq"
//    }
}
