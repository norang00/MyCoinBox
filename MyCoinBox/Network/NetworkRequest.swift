//
//  NetworkRequest.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/7/25.
//

import Foundation
import Alamofire

enum NetworkRequest {
    case market
    case trending
    case search(query: String)
    case detail(ids: String)
    
    var upbitURL: String {
        return API.URL.upbit.rawValue
    }
    
    var geckoURL: String {
        return API.URL.gecko.rawValue
    }
    
    var endpoint: URL {
        switch self {
        case .market:
            return URL(string: upbitURL)!
        case .trending:
            return URL(string: geckoURL+"/search/trending")!
        case .search:
            return URL(string: geckoURL+"/search")!
        case .detail:
            return URL(string: geckoURL+"/coins/markets")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters {
        switch self {
        case .market:
            return ["quote_currencies": "KRW"]
        case .trending:
            return [:] // no parameters
        case .search(let query):
            return ["query": query]
        case .detail(let ids):
            return ["vs_currency=krw": "krw",
                    "ids": ids]
        }
    }
}
