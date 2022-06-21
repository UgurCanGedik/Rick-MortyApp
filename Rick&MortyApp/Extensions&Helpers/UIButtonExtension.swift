//
//  UIButtonExtension.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 21.06.2022.
//

import UIKit

extension UIButton {
    
    func setButton(tag: Int) {
        
        self.backgroundColor = .clear
        self.tag = tag
        self.layer.zPosition = 2
    }
}
