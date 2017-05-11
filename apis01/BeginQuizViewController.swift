//
//  BeginQuizViewController.swift
//  apis01
//
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class BeginQuizViewController: UIViewController {

	@IBOutlet weak var puntajeMaximo: UILabel!
	@IBOutlet weak var puntajeAnterior: UILabel!
	@IBOutlet weak var btnIniciar: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		btnIniciar.layer.cornerRadius = 15
		btnIniciar.clipsToBounds = true
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		
		puntajeMaximo.text = String(UserDefaults.standard.integer(forKey: quizHighScoreIdentifier))
		
		puntajeAnterior.text = String(UserDefaults.standard.integer(forKey: quizRecentScoreIdentifier))
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
