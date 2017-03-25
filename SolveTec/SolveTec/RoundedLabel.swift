//
//  RoundedLabel.swift
//  SolveTec
//
//  Created by Elias Mera on 3/25/17.
//  Copyright © 2017 APIS. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {

    // Draws the UI elemetn (Label)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
    
    // Gives my label a little bit of padding
    override func drawText(in rect: CGRect) {
        let newRect = rect.insetBy(dx: 8.0, dy: 8.0)
        super.drawText(in: newRect)
    }

}
