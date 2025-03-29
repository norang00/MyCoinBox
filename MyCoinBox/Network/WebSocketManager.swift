//
//  WebSocketManager.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/27/25.
//

import Foundation

final class WebSocketManager {
    
    static let shared = WebSocketManager()    
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let session = URLSession(configuration: .default)
    
    private init() { }

    var onReceiveOrderBook: ((OrderBookData) -> Void)?
    
    func connect() {
        let url = URL(string: "wss://api.upbit.com/websocket/v1")!
        webSocketTask = session.webSocketTask(with: url)

        webSocketTask?.resume()
        listen()
        sendInitialMessage()
    }
    
    private func sendInitialMessage() {
        let message = [
            ["ticket": "test"],
            ["type": "orderbook", "codes": ["KRW-BTC"]]
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: message)
            let string = String(data: jsonData, encoding: .utf8)!
            webSocketTask?.send(.string(string)) { error in
                if let error = error {
                    print("❌ 메시지 전송 실패: \(error)")
                }
            }
        } catch {
            print("❌ 메시지 인코딩 실패: \(error)")
        }
    }
    
    private func listen() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    do {
                        let decoded = try JSONDecoder().decode(OrderBookData.self, from: data)
                        self?.onReceiveOrderBook?(decoded) // ✅ 전달
                    } catch {
                        print("❌ 디코딩 실패:", error)
                    }
                default:
                    break
                }
                self?.listen()
            case .failure(let error):
                print("❌ 수신 실패: \(error)")
            }
        }
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
