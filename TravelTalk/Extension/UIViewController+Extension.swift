//
//  UIViewController+Extension.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/11/25.
//

import UIKit

extension UIViewController {
    
    func setNavigationAppearance(_ title: String) {
        navigationItem.title = title
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black

        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .white
        navigationAppearance.shadowColor = .lightGray
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
    }
}
