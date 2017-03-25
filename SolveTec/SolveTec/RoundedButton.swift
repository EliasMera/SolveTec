//
//  RoundedButton.swift
//  SolveTec
//
//  Created by Elias Mera on 3/25/17.
//  Copyright © 2017 APIS. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    
    // Draws the UI elemetn (Button)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
 

}
