//
//  Friend.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

enum Friend: String {
    case hue = "Hue"
    case jack = "Jack"
    case bran = "Bran"
    case den = "Den"
    case user //본인
    case other_friend = "내옆자리의앞자리에개발잘하는친구"
    case simsim = "심심이"
    case test = "test"
    
    var profileImage: String {
        return rawValue
    }
}
