//
//  DBManager.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import Foundation
import RealmSwift

protocol LikeProtocol {
    func getLikedItem() -> Results<LikedCoin>
    func createLikedItem(coinId: String, name: String, symbol: String, thumb: String)
    func deleteLikedItem(coinId: String)
    func checkIsLiked(_ coinId: String) -> Bool
}

final class DBManager: LikeProtocol {
    
    static let shared = DBManager()

    private let realm = try! Realm()
    
    private init() { }
    
    func getFileURL() {
        print(realm.configuration.fileURL!)
    }
    
    func getLikedItem() -> Results<LikedCoin> {
        let data = realm.objects(LikedCoin.self)
        return data
    }

    func createLikedItem(coinId: String, name: String, symbol: String, thumb: String) {
        do {
            try realm.write {
                let data = LikedCoin(coinId: coinId, name: name, symbol: symbol, thumb: thumb)
                realm.add(data, update: .modified)
            }
        } catch {
            print("Realm save failed")
        }
    }
    
    func deleteLikedItem(coinId: String) {
        do {
            let data = realm.objects(LikedCoin.self).where { $0.coinId == coinId }
            try realm.write {
                realm.delete(data)
                print("Deleted item with coinId:", coinId)
            }
        } catch {
            print("Realm delete failed")
        }
    }
    
    func checkIsLiked(_ coinId: String) -> Bool {
        return realm.objects(LikedCoin.self)
            .where { $0.coinId == coinId }
            .first != nil
    }
}
