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
		let filePathQuestions = questionsFilePath()
		var questions = [MultipleChoiceQuestion]()
		
		if !FileManager.default.fileExists(atPath: filePathQuestions) {
			print("No existe el questions.plist, vamos a crearlo")
			
			let bundle = Bundle.main.path(forResource: "questions", ofType: "plist")
			do {
				try FileManager.default.copyItem(atPath: bundle!, toPath: filePathQuestions)
			} catch {
				print(error)
			}
			
			print("Archivo questions.plist creado")
		}
		
		
		if FileManager.default.fileExists(atPath: filePathQuestions) {
			let array = NSArray(contentsOfFile: filePathQuestions)
			let tempArray: Array = Array(array!) as! [Dictionary<String, AnyObject>]
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
		
		throw LoaderError.dictionaryFailed
	}
	
	func questionsFilePath() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let documentsDirectory = paths[0]
		return documentsDirectory.appending("/questions.plist")
	}
}
