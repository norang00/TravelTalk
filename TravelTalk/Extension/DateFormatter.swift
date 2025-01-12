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
    static let yyyyMMddHHmmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    static let yyMMddFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    static let HHmmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm a"
        return formatter
    }()
    
    static func convertToyyMMdd(_ input: String) -> String {
        var result: String = ""
        if let date = DateFormatter.yyyyMMddHHmmFormatter.date(from: input) {
            result = DateFormatter.yyMMddFormatter.string(from: date)
        }
        return result
    }
    
    static func convertToHHmm(_ input: String) -> String {
        var result: String = ""
        if let date = DateFormatter.yyyyMMddHHmmFormatter.date(from: input) {
            result = DateFormatter.HHmmFormatter.string(from: date)
        }
        return result
    }
}
