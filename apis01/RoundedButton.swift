//
//  RoundedButton.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/14/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
	
	// Draws the UI element (Button)
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		layer.cornerRadius = 5.0
		layer.masksToBounds = true
	}
}
