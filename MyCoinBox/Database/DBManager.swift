//
//  DBManager.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import Foundation
import RealmSwift

protocol LikeProtocol {
    func getLikedItem() -> Results<LikedItem>
    func createLikedItem(coinId: String)
    func deleteLikedItem(coinId: String)
}

final class DBManager: LikeProtocol {
    
    private let realm = try! Realm()
    
    func getFileURL() {
        print(realm.configuration.fileURL!)
    }
    
    func getLikedItem() -> Results<LikedItem> {
        let data = realm.objects(LikedItem.self)
        return data
    }

    func createLikedItem(coinId: String) {
        do {
            try realm.write {
                let data = LikedItem(coinId: coinId)
                realm.add(data)
            }
        } catch {
            print("Realm save failed")
        }
    }
    
    func deleteLikedItem(coinId: String) {
        do {
            let data = realm.objects(LikedItem.self).where { $0.coinId == coinId }
            try realm.write {
                realm.delete(data)
                print("Deleted item with coinId:", coinId)
            }
        } catch {
            print("Realm delete failed")
        }
    }
}
