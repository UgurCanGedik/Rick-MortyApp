//
//  UILabelExtensions.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 21.06.2022.
//

import UIKit

extension UILabel {

    func setLabel(_ textColor: UIColor = .black, font: UIFont, text: String, aligment: NSTextAlignment) {

        self.backgroundColor = .clear
        self.textColor = textColor
        self.textAlignment = aligment
        self.font = font
        self.text = text
    }
}
