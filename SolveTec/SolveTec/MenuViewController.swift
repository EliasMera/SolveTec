//
//  ViewController.swift
//  SolveTec
//
//  Created by Elias Mera on 3/25/17.
//  Copyright © 2017 APIS. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let contentView = UIView()
    private let logoView = UIImageView()
    private let buttonView = UIView()
    private var gameButtons = [RoundedButton]()
    private let scoreView = UIView()
    private let titleLabel = UILabel()
    private let recentScoreLabel = UILabel()
    private let highscoreLabel = UILabel()
    
    private let titles = [
        "Falso & Verdadero",
        "Opción Múltiple"
    ]
    
    private var recentScores = [Int]()
    private var highScores = [Int]()
    private var scoreIndex = 0
    private var timer = Timer()
    
    private var midXConstraints: [NSLayoutConstraint]!
    private var leftConstraints: [NSLayoutConstraint]!
    private var rightConstraints: [NSLayoutConstraint]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Access our navigation and changes colors
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        layoutView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        updateScores()
    }
    
    // Method that updates scores periodically
    func updateScores(){
        recentScores = [
            UserDefaults.standard.integer(forKey: multipleChoiceRecentScoreIdentifier),
            UserDefaults.standard.integer(forKey: falsoVerdaderoRecentScoreIdentifier)
        ]
        
        highScores = [
            UserDefaults.standard.integer(forKey: multipleChoiceHighScoreIdentifier),
            UserDefaults.standard.integer(forKey: falsoVerdaderoHighScoreIdentifier)
        ]
    }
    
    // Adds all views
    func layoutView(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoView)
        logoView.image = UIImage(named: "logo")
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonView)
        
        // Adds every button for the menu
        for (index, title) in titles.enumerated() {
            let button = RoundedButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonView.addSubview(button)
            button.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitle(title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
            gameButtons.append(button)
        }
        
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scoreView)
        
        // Adds title, recent score and highscore label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        recentScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        highscoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreView.addSubview(titleLabel)
        scoreView.addSubview(recentScoreLabel)
        scoreView.addSubview(highscoreLabel)
        // Gives the font attributes to title, recent score and highscore
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        recentScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        recentScoreLabel.textColor = UIColor.white
        highscoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        highscoreLabel.textColor = UIColor.white
        
        // This will be updated dinamically on-game
        titleLabel.text = titles[scoreIndex]
        recentScoreLabel.text = "Recent: " + String(UserDefaults.standard.integer(forKey: multipleChoiceHighScoreIdentifier))
        highscoreLabel.text = "Highscore: " + String(UserDefaults.standard.integer(forKey: multipleChoiceRecentScoreIdentifier))
        
        // Adds constraints
        let constraints = [
            contentView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            logoView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            buttonView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20.0),
            buttonView.bottomAnchor.constraint(equalTo: scoreView.topAnchor, constant: -20.0),
            buttonView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            buttonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gameButtons[0].topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 8.0),
            gameButtons[0].bottomAnchor.constraint(equalTo: gameButtons[1].topAnchor, constant: -8.0),
            gameButtons[0].leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            gameButtons[0].trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            gameButtons[1].bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -8.0),
            gameButtons[1].leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            gameButtons[1].trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            gameButtons[0].heightAnchor.constraint(equalTo: gameButtons[1].heightAnchor),
            scoreView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0),
            scoreView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            scoreView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            titleLabel.topAnchor.constraint(equalTo: scoreView.topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: scoreView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: recentScoreLabel.topAnchor, constant: -8.0),
            recentScoreLabel.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor),
            recentScoreLabel.trailingAnchor.constraint(equalTo: scoreView.trailingAnchor),
            recentScoreLabel.bottomAnchor.constraint(equalTo: highscoreLabel.topAnchor, constant: -8.0),
            highscoreLabel.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor),
            highscoreLabel.trailingAnchor.constraint(equalTo: scoreView.trailingAnchor),
            highscoreLabel.bottomAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: -8.0),
            titleLabel.heightAnchor.constraint(equalTo: recentScoreLabel.heightAnchor),
            recentScoreLabel.heightAnchor.constraint(equalTo: highscoreLabel.heightAnchor)
        ]
        
        midXConstraints = [scoreView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)]
        leftConstraints = [scoreView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor)]
        rightConstraints = [scoreView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor)]
        
        // Activates constraints
        NSLayoutConstraint.activate(constraints)
        NSLayoutConstraint.activate(midXConstraints)
        
        
        // Sets the timer and activates the animation
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextScores), userInfo: nil, repeats: true)
    }
    
    // Method give functionality to our buttons
    func buttonHandler(sender: RoundedButton){
        var vc: UIViewController?
        
        switch sender.tag {
        case 0:
            // Falso y verdadero
            print("Falso y verdadero")
        case 1:
            // Multiple Choice
            vc = MultipleChoiceViewController()
        default:
            break
        }
        
        if let newVC = vc {
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    
    // Method that animates the change of highscores
    func nextScores(){
        scoreIndex = scoreIndex < (recentScores.count - 1) ? scoreIndex + 1 : 0
        // Animation happens
        UIView.animate(withDuration: 1.0, animations: {
            NSLayoutConstraint.deactivate(self.midXConstraints)
            NSLayoutConstraint.activate(self.leftConstraints)
            self.view.layoutIfNeeded()
        }) { (completion: Bool) in
                self.titleLabel.text = self.titles[self.scoreIndex]
                self.recentScoreLabel.text = "Recent: " + String(self.recentScores[self.scoreIndex])
                self.highscoreLabel.text = "Highscore " + String(self.highScores[self.scoreIndex])
                NSLayoutConstraint.deactivate(self.leftConstraints)
                NSLayoutConstraint.activate(self.rightConstraints)
                self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1.0, animations: {
                NSLayoutConstraint.deactivate(self.rightConstraints)
                NSLayoutConstraint.activate(self.midXConstraints)
                self.view.layoutIfNeeded()
            })
        }
    }


}

