//
//  ProfileViewController.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/10/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {

	@IBOutlet weak var profileScroll: UIScrollView!
	@IBOutlet weak var profileView: UIView!
	@IBOutlet weak var containerView: UIView!
	
	@IBOutlet weak var imgCircle: UIImageView!
	@IBOutlet weak var tfNombre: UITextField!
	@IBOutlet weak var lbNombreSuperior: UILabel!
	@IBOutlet weak var lbNivelGrande: UILabel!
	@IBOutlet weak var lbNivelChico: UILabel!
	@IBOutlet weak var lbHighscore: UILabel!
	@IBOutlet weak var lbPuntajeMeta: UILabel!
	@IBOutlet weak var lbJuegosRestantes: UILabel!
	
	// text color for level changes
	let greenText = UIColor(red: 103/255, green: 117/255, blue: 69/255, alpha: 1.0)
	let blueText = UIColor(red: 13/255, green: 101/255, blue: 127/255, alpha: 1.0)
	let yellowText = UIColor(red: 132/255, green: 113/255, blue: 39/255, alpha: 1.0)
	
    override func viewDidLoad() {
//        super.viewDidLoad()
		profileScroll.contentSize = profileView.frame.size
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
		
		tap.cancelsTouchesInView = false
		
		view.addGestureRecognizer(tap)
    }
	
	func dismissKeyboard() {
		view.endEditing(true)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if let path = Bundle.main.path(forResource: "userProfile", ofType: "plist") {
			if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
				let nivel = dic["nivel"] as! String?
				if Int(nivel!)! <= 5 {
					imgCircle.image = #imageLiteral(resourceName: "circle-green")
					lbNombreSuperior.textColor = greenText
				} else if Int(nivel!)! <= 9 {
					imgCircle.image = #imageLiteral(resourceName: "circle-blue")
					lbNombreSuperior.textColor = blueText
				} else {
					imgCircle.image = #imageLiteral(resourceName: "circle-yellow")
					lbNombreSuperior.textColor = yellowText
				}
				lbNivelGrande.text = nivel
				lbNivelChico.text = nivel
				lbHighscore.text = dic["highscore"] as! String?
				lbPuntajeMeta.text = dic["puntajeMeta"] as! String?
				lbJuegosRestantes.text = dic["juegosRestantes"] as! String?
				lbNombreSuperior.text = dic["nombre"] as! String?
				tfNombre.text = dic["nombre"] as! String?
//				let areasDeOportunidad = dic["Areas de Oportunidad"] as! [[String:Bool]]
//				for item in areasDeOportunidad {
//					if item["Oportunidad"] == true {
//						// Add item to the table view
//						
//					}
//				}
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	@IBAction func modificaNombre(_ sender: UITextField) {
		
		lbNombreSuperior.text = sender.text
		if let path = Bundle.main.path(forResource: "userProfile", ofType: "plist") {
			if let dict = NSMutableDictionary(contentsOfFile: path) {
				dict.setValue(sender.text, forKey: "nombre")
				dict.write(toFile: path, atomically: false)
			}
		}
	}
	
	@IBAction func infoObjetivo(_ sender: UIButton) {
		//TODO
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
