//
//  StringExtensions.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 20.06.2022.
//

import Foundation
import UIKit

extension NSMutableAttributedString {

    func createAttributedString(String1: String,
                                Font1: UIFont,
                                Color1: UIColor,
                                String2: String,
                                Font2: UIFont,
                                Color2: UIColor) -> NSMutableAttributedString {

        let firstString = NSMutableAttributedString.init(string: String1)
        firstString.setAttributes([NSAttributedString.Key.font: Font1 ,NSAttributedString.Key.foregroundColor: Color1],range: NSMakeRange(0, String1.count))
        let secondString = NSMutableAttributedString.init(string: String2)
        secondString.setAttributes([NSAttributedString.Key.font: Font2 ,NSAttributedString.Key.foregroundColor: Color2],range: NSMakeRange(0, String2.count))
        firstString.append(secondString)
        return firstString
    }
}
