//
//  UILabel+Extension.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

import UIKit

extension UILabel {
    
    static func make(title: String,
                     font: UIFont,
                     alignment: NSTextAlignment = .center,
                     numberOfLines: Int = 0,
                     adjustsFontSize: Bool = false,
                     textColor: UIColor? = nil) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = adjustsFontSize
        label.minimumScaleFactor = adjustsFontSize ? 0.6 : 1.0
        if let textColor = textColor {
            label.textColor = textColor
        }
        return label
    }
}
