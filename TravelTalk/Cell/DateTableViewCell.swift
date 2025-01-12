//
//  DateTableViewCell.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/12/25.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }

    func configure() {
        dateLabel.text = ""
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        dateLabel.numberOfLines = 1
    }
    
    func configureData(_ date: Date) {
        dateLabel.text = DateFormatter.yyMMddFormatter.string(from: date)
    }
}
