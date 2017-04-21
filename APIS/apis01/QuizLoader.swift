//
//  QuizLoader.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/14/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import Foundation

// Question class
struct MultipleChoiceQuestion {
	let question: String
	let correctAnswer: String
	let answers: [String]
    let category: String
}

enum LoaderError: Error {
	case dictionaryFailed, pathFailed
}

class QuizLoader {
	public func loadQuiz() throws -> [MultipleChoiceQuestion] {
		var questions = [MultipleChoiceQuestion]()
		if let path = Bundle.main.path(forResource: "questions", ofType: "plist") {
			if let array = NSArray(contentsOfFile: path) {
//				let tempArray: Array = dict["Root"]! as! [Dictionary<String, AnyObject>]
				let tempArray: Array = Array(array) as! [Dictionary<String, AnyObject>]
				for dictionary in tempArray {
					let questionToAdd = MultipleChoiceQuestion(
						question: dictionary["pregunta"] as! String,
						correctAnswer: dictionary["correct_option"] as! String,
						answers: dictionary["options"] as! [String],
						category: dictionary["id_categoria"] as! String)
					questions.append(questionToAdd)
				}
				
				return questions
			}
			else{
				throw LoaderError.dictionaryFailed
			}
		} else {
			throw LoaderError.pathFailed
		}
	}
}
