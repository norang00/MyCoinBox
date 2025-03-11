//
//  NetworkMonitor.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/11/25.
//

import Foundation
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
        
    private let queue = DispatchQueue.global(qos: .background)
    var monitor: NWPathMonitor
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func getCurrentStatus(completion: @escaping (NWPath.Status) -> Void) {
        let tempMonitor = NWPathMonitor()
        tempMonitor.pathUpdateHandler = { path in
            print(path.status)
            completion(path.status)
            tempMonitor.cancel()
        }
        tempMonitor.start(queue: DispatchQueue.main)
    }
    
    func startMonitoring(statusUpdateHandler: @escaping (NWPath.Status) -> Void) {
        print(#function)
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                statusUpdateHandler(path.status)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        print(#function)
        monitor.cancel()
    }
}
