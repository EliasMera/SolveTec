//
//  RoundedLabel.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/14/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {
	
	// Draws the UI element (Label)
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		layer.cornerRadius = 5.0
		layer.masksToBounds = true
	}
	
	// Gives the label a little bit of padding
	override func drawText(in rect: CGRect) {
		let newRect = rect.insetBy(dx: 8.0, dy: 8.0)
		super.drawText(in: newRect)
	}
	
}
