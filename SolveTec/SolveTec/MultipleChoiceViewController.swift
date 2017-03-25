//
//  MultipleChoiceViewController.swift
//  SolveTec
//
//  Created by Elias Mera on 3/25/17.
//  Copyright © 2017 APIS. All rights reserved.
//

import UIKit

class MultipleChoiceViewController: UIViewController {
    
    // Creates graphic elements
    private let contentView = UIView()
    private var contentViewConstraints: [NSLayoutConstraint]!
    
    private let questionView = UIView()
    private var questionViewConstraints: [NSLayoutConstraint]!
    
    private let answerView = UIView()
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
    private var highscore = UserDefaults.standard.integer(forKey: multipleChoiceHighScoreIdentifier)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        layoutView()
        loadQuestions()
    }
    
    // Makes the navigation bar appear in top of the screen
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // Initializer Adds constraints and views to screen
    func layoutView(){
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
        questionButton.addTarget(self, action: #selector(questionButtonHandler), for: .touchUpInside)
        questionButton.isEnabled = false
        
        answerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(answerView)
        for _ in 0...3 { // Adds 4 different options
            let button = RoundedButton()
            answerButtons.append(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            answerView.addSubview(button)
            button.addTarget(self, action: #selector(answerButtonHandler), for: .touchUpInside)
        }
        
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
    
    // Loads questions duuh
    func loadQuestions() {
        do {
            questionArray = try quizLoader.loadMultipleChoiceQuiz(forQuiz: "MultipleChoice")
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
    
    // Loads next question duuh x2
    func loadNextQuestion(){
        currentQuestion = questionArray[questionIndex]
        setTitlesForButtons()
    }
    
    // Sets titles for buttons duuh x3
    func setTitlesForButtons(){
        for(index,button) in answerButtons.enumerated() {
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.setTitle(currentQuestion.answers[index], for: .normal)
            button.isEnabled = true
            button.backgroundColor = foregroundColor
        }
        questionLabel.text = currentQuestion.question
        startTimer()
    }
    
    
    // colors with our custom colors
    func startTimer() {
        progressView.progressTintColor = flatGreen
        progressView.trackTintColor = UIColor.clear
        progressView.progress = 1.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }
    
    // Changes the color of the timer depending on how much time is left
    func updateProgressView() {
        progressView.progress -= 0.01/30 // 30 seconds
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
    func outOfTime(){
        timer.invalidate()
        for button in answerButtons {
            button.isEnabled = false
        }
        showAlert(forReason: 0)
    }
    
    func questionButtonHandler() {
        questionButton.isEnabled = false
        questionIndex += 1
        // Checks if the user answered all the questions
        questionIndex < questionArray.count ? loadNextQuestion() : showAlert(forReason: 2)
    }
    
    // colors the button if correct, or incorrect
    func answerButtonHandler(_ sender: RoundedButton){
        timer.invalidate()
        if sender.titleLabel?.text == currentQuestion.correctAnswer {
            score += 1
            questionLabel.text = "Click aqui para continuar"
            questionButton.isEnabled = true
        } else {
            sender.backgroundColor = flatRed
            showAlert(forReason: 1)
        }
        for button in answerButtons {
            button.isEnabled = false
            if button.titleLabel?.text == currentQuestion.correctAnswer {
                button.backgroundColor = flatGreen
            }
        }
    }
    
    // Method that shows an alert depending on the message
    func showAlert(forReason reason: Int) {
        let avc = UIAlertController()
        switch reason {
        case 0:
            avc.title = "Perdiste"
            avc.message = "Se acabó el tiempo"
        case 1:
            avc.title = "Perdiste"
            avc.message = "Respuesta incorrecta"
        case 2:
            avc.title = "Ganaste"
            avc.message = "Contestaste todas las respuestas correctamente"
        default:
            break
        }
        
        let ok = UIAlertAction(title: "Continuar", style: .default, handler: nil)
        avc.addAction(ok)
        present(avc, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
