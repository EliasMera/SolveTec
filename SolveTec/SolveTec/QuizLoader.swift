//
//  QuizLoader.swift
//  SolveTec
//
//  Created by Elias Mera on 3/25/17.
//  Copyright © 2017 APIS. All rights reserved.
//

import Foundation

// Question class
struct MultipleChoiceQuestion {
    let question: String
    let correctAnswer: String
    let answers: [String]
}

enum LoaderError: Error {
    case dictionaryFailed, pathFailed
}

class QuizLoader {
    
    public func loadMultipleChoiceQuiz(forQuiz quizName: String) throws -> [MultipleChoiceQuestion] {
        var questions = [MultipleChoiceQuestion]()
        if let path = Bundle.main.path(forResource: quizName, ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path){
                let tempArray: Array = dict["Questions"]! as! [Dictionary<String, AnyObject>]
                // traverse 1 by 1
                for dictionary in tempArray {
                    let questionToAdd = MultipleChoiceQuestion(question: dictionary["Question"] as! String, correctAnswer: dictionary["CorrectAnswer"] as! String, answers: dictionary["Answers"] as! [String])
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
