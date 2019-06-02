//
//  MyViewProtocol.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/3/25.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
import UIKit
protocol MyViewProtocol {
    var customBackgroundColor: UIColor{ get }
}

extension MyViewProtocol where Self: UIView {
    func addBorder(){
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 1
    }
    func addBackgroundColor() {
        backgroundColor = customBackgroundColor
    }
}
