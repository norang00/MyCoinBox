//
//  DateFormatter+Extension.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/8/25.
//

import Foundation

extension DateFormatter {

    static let basic: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy년 M월 d일"
        return formatter
    }()

    static let trending: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM.dd HH:mm 기준"
        return formatter
    }()
    
    static let update: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M/d HH:mm:ss 업데이트"
        return formatter
    }()
}
