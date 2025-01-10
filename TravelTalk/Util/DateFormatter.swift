//
//  DateFormatter.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//
// 참고 블로그... 클로저를 이용한 객체 생성
// https://etst.tistory.com/367

import Foundation

extension DateFormatter {
    static let inputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    static let outputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()

    static func convertFormat(_ input: String) -> String {
        var result: String = ""
        if let date = DateFormatter.inputFormatter.date(from: input) {
            result = DateFormatter.outputFormatter.string(from: date)
        }
        return result
    }
}
