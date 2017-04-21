//
//  QuizViewController.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/14/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

	// Creates graphic elements
	private let contentView = UIView()
	private var contentViewConstraints: [NSLayoutConstraint]!
	
	private let questionView = UIView()
	private var questionViewConstraints: [NSLayoutConstraint]!
	
	private var answerView = UIView()
	private var answerViewConstraints: [NSLayoutConstraint]!
	
	private let countdownView = UIView()
	private var countdownViewConstraints: [NSLayoutConstraint]!
	
	private let questionLabel = RoundedLabel()
	private var questionLabelConstraints: [NSLayoutConstraint]!
	private let questionButton = RoundedButton()
	private var questionButtonConstraints: [NSLayoutConstraint]!
	
	private var answerButtons = [RoundedButton]()
	private var answerButtonsConstraints: [NSLayoutConstraint]!
	
	private let progressView = UIProgressView()
	private var progressViewConstraints: [NSLayoutConstraint]!
	
	private let backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
	private let foregroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
	
	private let quizLoader = QuizLoader()
	private var questionArray = [MultipleChoiceQuestion]()
	private var questionIndex = 0
	private var currentQuestion: MultipleChoiceQuestion!
	
	private var timer = Timer()
	private var score = 0
	private var totalTime: Double = 0
	
	// Change identifier
	private var highscore = UserDefaults.standard.integer(forKey: quizHighScoreIdentifier)
	
	private var quizAlertView: QuizAlertView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = backgroundColor
		
		if let path = Bundle.main.path(forResource: "userProfile", ofType: "plist") {
			if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
				let segundos = dic["timer"] as! String?
				totalTime = Double(segundos!)!
			}
		}
		
		loadQuestions()
		layoutView()
		startTimer()
	}
	
	// Makes the navigation bar appear in top of the screen
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
	}
	
	// Initializer Adds constraints and views to screen
	func layoutView() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(contentView)
		
		questionView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(questionView)
		questionLabel.translatesAutoresizingMaskIntoConstraints = false
		questionView.addSubview(questionLabel)
		questionLabel.backgroundColor = foregroundColor
		questionLabel.textColor = UIColor.white
		questionLabel.font = UIFont.boldSystemFont(ofSize: 20)
		questionLabel.textAlignment = .center
		questionLabel.numberOfLines = 4
		questionLabel.adjustsFontSizeToFitWidth = true
		questionButton.translatesAutoresizingMaskIntoConstraints = false
		questionView.addSubview(questionButton)
		//questionButton.addTarget(self, action: #selector(questionButtonHandler), for: .touchUpInside)
		questionButton.isEnabled = false
		
		answerView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(answerView)

		countdownView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(countdownView)
		progressView.translatesAutoresizingMaskIntoConstraints = false
		countdownView.addSubview(progressView)
		progressView.transform = progressView.transform.scaledBy(x: 1, y: 10)
		
		contentViewConstraints = [
			contentView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		]
		
		questionViewConstraints = [
			questionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
			questionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
			questionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
			questionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
		]
		
		questionLabelConstraints = [
			questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor),
			questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
			questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor),
			questionLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor)
		]
		
		questionButtonConstraints = [
			questionButton.topAnchor.constraint(equalTo: questionView.topAnchor),
			questionButton.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
			questionButton.trailingAnchor.constraint(equalTo: questionView.trailingAnchor),
			questionButton.bottomAnchor.constraint(equalTo: questionView.bottomAnchor)
		]
		
		answerViewConstraints = [
			answerView.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 20.0),
			answerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
			answerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
			answerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
		]
		
		if currentQuestion.answers.count == 2 {
			answerButtonsConstraints = [
				answerButtons[0].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
				answerButtons[0].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
				answerButtons[0].topAnchor.constraint(equalTo: answerView.topAnchor),
				answerButtons[0].bottomAnchor.constraint(equalTo: answerButtons[1].topAnchor, constant: -8.0),
				answerButtons[1].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
				answerButtons[1].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
				answerButtons[1].bottomAnchor.constraint(equalTo: answerView.bottomAnchor),
				answerButtons[0].heightAnchor.constraint(equalTo: answerButtons[1].heightAnchor),
				answerButtons[0].widthAnchor.constraint(equalTo: answerButtons[1].widthAnchor)
			]
		} else {
			answerButtonsConstraints = [
				answerButtons[0].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
				answerButtons[0].trailingAnchor.constraint(equalTo: answerButtons[1].leadingAnchor, constant: -8.0),
				answerButtons[0].topAnchor.constraint(equalTo: answerView.topAnchor),
				answerButtons[0].bottomAnchor.constraint(equalTo: answerButtons[2].topAnchor, constant: -8.0),
				answerButtons[1].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
				answerButtons[1].topAnchor.constraint(equalTo: answerView.topAnchor),
				answerButtons[1].bottomAnchor.constraint(equalTo: answerButtons[3].topAnchor, constant: -8.0),
				answerButtons[2].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
				answerButtons[2].trailingAnchor.constraint(equalTo: answerButtons[3].leadingAnchor, constant: -8.0),
				answerButtons[2].bottomAnchor.constraint(equalTo: answerView.bottomAnchor),
				answerButtons[3].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
				answerButtons[3].bottomAnchor.constraint(equalTo: answerView.bottomAnchor)
			]
			
			// every button of the same size
			for index in 1..<answerButtons.count {
				answerButtonsConstraints.append(answerButtons[index].heightAnchor.constraint(equalTo: answerButtons[index - 1].heightAnchor))
				answerButtonsConstraints.append(answerButtons[index].widthAnchor.constraint(equalTo: answerButtons[index - 1].widthAnchor))
			}
		}
		
		countdownViewConstraints = [
			countdownView.topAnchor.constraint(equalTo: answerView.bottomAnchor, constant: 20.0),
			countdownView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
			countdownView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
			countdownView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0)
		]
		
		progressViewConstraints = [
			progressView.leadingAnchor.constraint(equalTo: countdownView.leadingAnchor),
			progressView.trailingAnchor.constraint(equalTo: countdownView.trailingAnchor),
			progressView.centerYAnchor.constraint(equalTo: countdownView.centerYAnchor)
		]
		
		// Activates constraints
		NSLayoutConstraint.activate(contentViewConstraints)
		NSLayoutConstraint.activate(questionViewConstraints)
		NSLayoutConstraint.activate(questionLabelConstraints)
		NSLayoutConstraint.activate(questionButtonConstraints)
		NSLayoutConstraint.activate(answerViewConstraints)
		NSLayoutConstraint.activate(answerButtonsConstraints)
		NSLayoutConstraint.activate(countdownViewConstraints)
		NSLayoutConstraint.activate(progressViewConstraints)
	}
	
	func loadQuestions() {
		do {
			questionArray = try quizLoader.loadQuiz()
			questionArray.shuffle()
			loadNextQuestion()
		} catch {
			switch error {
			case LoaderError.dictionaryFailed:
				print("No se pudo cargar el diccionario")
			case LoaderError.pathFailed:
				print("No se encontro el archivo")
			default:
				print("Error desconocido")
			}
		}
	}
	
	func loadNextQuestion(){
		if currentQuestion != nil{
			for index in 0...currentQuestion.answers.count-1{
				answerButtons[index].removeFromSuperview()
			}
			
		}
		
		currentQuestion = questionArray[questionIndex]
		answerButtons = [RoundedButton]()
		if currentQuestion.answers.count == 2{
			for index in 0...1 {
				let button = RoundedButton()
				answerButtons.append(button)
				button.translatesAutoresizingMaskIntoConstraints = false
				answerView.addSubview(button)
				index == 0 ? button.setTitle("Verdadero", for: .normal) : button.setTitle("Falso", for: .normal)
				button.addTarget(self, action: #selector(answerButtonHandler), for: .touchUpInside)
			}
            
            answerButtonsConstraints = [
                answerButtons[0].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
                answerButtons[0].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
                answerButtons[0].topAnchor.constraint(equalTo: answerView.topAnchor),
                answerButtons[0].bottomAnchor.constraint(equalTo: answerButtons[1].topAnchor, constant: -8.0),
                answerButtons[1].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
                answerButtons[1].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
                answerButtons[1].bottomAnchor.constraint(equalTo: answerView.bottomAnchor),
                answerButtons[0].heightAnchor.constraint(equalTo: answerButtons[1].heightAnchor),
                answerButtons[0].widthAnchor.constraint(equalTo: answerButtons[1].widthAnchor)
            ]
		} else {
			for _ in 0...3 {
				let button = RoundedButton()
				answerButtons.append(button)
				button.translatesAutoresizingMaskIntoConstraints = false
				answerView.addSubview(button)
				button.addTarget(self, action: #selector(answerButtonHandler), for: .touchUpInside)
			}
            answerButtonsConstraints = [
                answerButtons[0].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
                answerButtons[0].trailingAnchor.constraint(equalTo: answerButtons[1].leadingAnchor, constant: -8.0),
                answerButtons[0].topAnchor.constraint(equalTo: answerView.topAnchor),
                answerButtons[0].bottomAnchor.constraint(equalTo: answerButtons[2].topAnchor, constant: -8.0),
                answerButtons[1].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
                answerButtons[1].topAnchor.constraint(equalTo: answerView.topAnchor),
                answerButtons[1].bottomAnchor.constraint(equalTo: answerButtons[3].topAnchor, constant: -8.0),
                answerButtons[2].leadingAnchor.constraint(equalTo: answerView.leadingAnchor),
                answerButtons[2].trailingAnchor.constraint(equalTo: answerButtons[3].leadingAnchor, constant: -8.0),
                answerButtons[2].bottomAnchor.constraint(equalTo: answerView.bottomAnchor),
                answerButtons[3].trailingAnchor.constraint(equalTo: answerView.trailingAnchor),
                answerButtons[3].bottomAnchor.constraint(equalTo: answerView.bottomAnchor)
            ]
            
            for index in 1..<answerButtons.count {
                answerButtonsConstraints.append(answerButtons[index].heightAnchor.constraint(equalTo: answerButtons[index - 1].heightAnchor))
                answerButtonsConstraints.append(answerButtons[index].widthAnchor.constraint(equalTo: answerButtons[index - 1].widthAnchor))
            }
		}
        
        NSLayoutConstraint.activate(answerButtonsConstraints)
		setTitlesForButtons()
	}
	
	func setTitlesForButtons(){
		if answerButtons.count == 2{
			for button in answerButtons {
				button.isEnabled = true
				button.backgroundColor = foregroundColor
				button.setTitleColor(UIColor.white, for: .normal)
			}
		}
		else{
			for(index,button) in answerButtons.enumerated() {
				button.titleLabel?.lineBreakMode = .byWordWrapping
				button.setTitle(currentQuestion.answers[index], for: .normal)
				button.isEnabled = true
				button.backgroundColor = foregroundColor
			}
		}
		
		questionLabel.text = currentQuestion.question
	}
	
	// Colors with our custom colors
	func startTimer() {
		progressView.progressTintColor = flatGreen
		progressView.trackTintColor = UIColor.clear
		progressView.progress = 1.0
		timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
	}
	
	// Changes the color of the timer depending on how much time is left
	func updateProgressView() {
		progressView.progress -= Float(0.01 / totalTime)
		if progressView.progress <= 0 {
			// Game over
			outOfTime()
		} else if progressView.progress <= 0.2 {
			progressView.progressTintColor = flatRed
		} else if progressView.progress <= 0.5 {
			progressView.progressTintColor = flatOrange
		}
	}
	
	// Stops the timer and buttons since time ran out
	func outOfTime() {
		timer.invalidate()
		for button in answerButtons {
			button.isEnabled = false
		}
		showAlert(forReason: 0)
	}
	
	// Colors the button if correct or incorrect
	func answerButtonHandler(_ sender: RoundedButton) {
		//timer.invalidate()
		if sender.titleLabel?.text == currentQuestion.correctAnswer {
			//correctMusicPlayer.play()
			score += 5
		} else {
			//wrongMusicPlayer.play()
			sender.backgroundColor = flatRed
			questionButton.isEnabled = true
		}
		for button in answerButtons {
			button.isEnabled = false
			if button.titleLabel?.text == currentQuestion.correctAnswer {
				button.backgroundColor = flatGreen
			}
		}
		
		
		
		// Waits to change question
		let when = DispatchTime.now() + 0.35 // delays for 35 ms
		DispatchQueue.main.asyncAfter(deadline: when) {
			self.questionIndex += 1
			if self.questionIndex >= self.questionArray.count {
				self.questionIndex = 0
				self.questionArray.shuffle()
			}
			self.loadNextQuestion()
		}
	}
	
	// Method that shows an alert depending on the message
	func showAlert(forReason reason: Int) {
		switch reason {
		case 0:
			quizAlertView = QuizAlertView(withTitle: "Se acabó el tiempo", andMessage: "Puntuación " + String(score), colors: [backgroundColor, foregroundColor])
		case 1:
			quizAlertView = QuizAlertView(withTitle: "Fin del juego", andMessage: "Respuesta incorrecta", colors: [backgroundColor, foregroundColor])
		case 2:
			quizAlertView = QuizAlertView(withTitle: "Fin del juego", andMessage: "Contestaste todas las preguntas de manera correcta!", colors: [backgroundColor, foregroundColor])
		default:
			break
		}
		
		// Checks if alert is created
		if let qav = quizAlertView {
			quizAlertView?.closeButton.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
			createQuizAlertView(withAlert: qav)
		}
	}
	
	// Creates alert and sets constraints
	func createQuizAlertView(withAlert alert: QuizAlertView) {
		alert.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(alert)
		
		// constraints for the alert
		alert.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		alert.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		alert.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		alert.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	// Returns to the main menu after alert and updates the scores
	func closeAlert() {
		// checks the highscore
		if score > highscore {
			highscore = score
			UserDefaults.standard.set(highscore, forKey: quizHighScoreIdentifier)
		}
		
		UserDefaults.standard.set(score, forKey: quizRecentScoreIdentifier)
        
        
        // actualiza plist
        if let path = Bundle.main.path(forResource: "userProfile", ofType: "plist") {
            if let dic = NSMutableDictionary(contentsOfFile: path) {
                var hs = Int(dic["highscore"] as! String)!
                var nivel = Int(dic["nivel"] as! String)!
                var puntMeta = Int(dic["puntajeMeta"] as! String)!
                var juegRest = Int(dic["juegosRestantes"] as! String)!
                
                if score >= puntMeta {
                    juegRest -= 1
                    if juegRest <= 0 {
                        nivel = min(10, nivel + 1)
                        juegRest = nivel
                        puntMeta = 10*nivel
                    }
                }
                else {
                    juegRest = nivel
                }
                
                dic["highscore"] = String(highscore)
                dic["nivel"] = String(nivel)
                dic["puntajeMeta"] = String(puntMeta)
                dic["juegosRestantes"] = String(juegRest)
                
                dic.write(toFile: path, atomically: true)
            }
            else{
                print("Cargo mal chavo")
            }
        } else {
            print("No cargo chavo")
        }
		
		// Lleva a resultados
		//let vc = self.storyboard?.instantiateViewController(withIdentifier: "SBResultados")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu")
		navigationController?.pushViewController(vc!, animated: true)
	}
	
	
	// Function that nothing runs in the background
	override func didMove(toParentViewController parent: UIViewController?) {
		super.didMove(toParentViewController: parent)
		if parent == nil {
			timer.invalidate()
		}
	}

}
