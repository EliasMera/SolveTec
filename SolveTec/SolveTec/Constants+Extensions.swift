//
//  Constants+Extensions.swift
//  SolveTec
//
//  Created by Elias Mera on 3/25/17.
//  Copyright © 2017 APIS. All rights reserved.
//

import Foundation
import UIKit

// Extension para shufflear las preguntas
extension Array {
    mutating func shuffle() {
        if count < 2 {
            return
        }
        
        for i in 0..<(count - 1) {
            var j = 0
            while j == i {
                j = Int(arc4random_uniform(UInt32(count)))
            }
            swap(&self[i], &self[j])
        }
    }
}

let falsoVerdaderoHighScoreIdentifier = "FalsoVerdaderoHighScoreIdentifier"
let falsoVerdaderoRecentScoreIdentifier = "FalsoVerdaderoRecentScoreIdentifier"

let multipleChoiceHighScoreIdentifier = "MultipleChoiceHighScoreIdentifier"
let multipleChoiceRecentScoreIdentifier = "MultipleChoiceRecentScoreIdentifier"

let flatGreen = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
let flatOrange = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1.0)
let flatRed = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
