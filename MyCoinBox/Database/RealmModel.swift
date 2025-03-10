//
//  RealmModel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/10/25.
//

import Foundation
import RealmSwift

class LikedItem: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinId: String
    
    convenience init(coinId: String) {
        self.init()
        self.coinId = coinId
    }
}
