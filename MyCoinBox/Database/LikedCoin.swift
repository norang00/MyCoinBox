//
//  LikedCoin.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/10/25.
//

import Foundation
import RealmSwift

class LikedCoin: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinId: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var thumb: String
 
    convenience init(coinId: String, name: String, symbol: String, thumb: String) {
        self.init()
        self.coinId = coinId
        self.name = name
        self.symbol = symbol
        self.thumb = thumb
    }
}
