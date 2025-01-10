//
//  User.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

enum User: String {
    case hue = "Hue"
    case jack = "Jack"
    case bran = "Bran"
    case den = "Den"
    case user //본인
    case other_friend = "내옆자리의앞자리에개발잘하는친구"
    case simsim = "심심이"
    
    var profileImage: String {
        return rawValue
    }
}
