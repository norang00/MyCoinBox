//
//  DateFormatter+Extension.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import Foundation

extension DateFormatter {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
}
