//
//  changeShapes.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-18.
//

import Foundation
import UIKit

extension UIImageView{
    
    func CircleImg(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}

extension UILabel{
    func Rounded(){
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
