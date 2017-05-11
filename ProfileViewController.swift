//
//  ProfileViewController.swift
//  apis01
//
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
	let greenText = UIColor(red: 109/255, green: 182/255, blue: 186/255, alpha: 1.0)
	let blueText = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
	let yellowText = UIColor(red: 44/255, green: 49/255, blue: 79/255, alpha: 1.0)
	
    override func viewDidLoad() {
//        super.viewDidLoad()
		profileScroll.contentSize = profileView.frame.size
		
		let filePathUser = userProfileFilePath()
		
		if !FileManager.default.fileExists(atPath: filePathUser) {
			print("No existe el userProfile.plist, vamos a crearlo")
			
			let bundle = Bundle.main.path(forResource: "userProfile", ofType: "plist")
			do {
				try FileManager.default.copyItem(atPath: bundle!, toPath: filePathUser)
			} catch {
				print(error)
			}
			
			print("Archivo userProfile.plist creado")
		}
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
		
		tap.cancelsTouchesInView = false
		
		view.addGestureRecognizer(tap)
    }
	
	func dismissKeyboard() {
		view.endEditing(true)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let filePathUser = userProfileFilePath()
		if FileManager.default.fileExists(atPath: filePathUser) {
			let dic = NSMutableDictionary(contentsOfFile: filePathUser)
			let nivel = dic?["nivel"] as! String?
			if Int(nivel!)! <= 5 {
				imgCircle.image = #imageLiteral(resourceName: "circle-green")
			} else if Int(nivel!)! <= 9 {
				imgCircle.image = #imageLiteral(resourceName: "circle-blue")
			} else {
				imgCircle.image = #imageLiteral(resourceName: "circle-yellow")
			}
			lbNivelGrande.text = nivel
			lbNivelChico.text = nivel
			lbHighscore.text = dic?["highscore"] as! String?
			lbPuntajeMeta.text = dic?["puntajeMeta"] as! String?
			lbJuegosRestantes.text = dic?["juegosRestantes"] as! String?
			lbNombreSuperior.text = dic?["nombre"] as! String?
			tfNombre.text = dic?["nombre"] as! String?
			dic?.write(toFile: filePathUser, atomically: true)
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	@IBAction func modificaNombre(_ sender: UITextField) {
		lbNombreSuperior.text = sender.text

		let filePathUser = userProfileFilePath()
		if FileManager.default.fileExists(atPath: filePathUser) {
			let dict = NSMutableDictionary(contentsOfFile: filePathUser)
			dict?.setValue(sender.text, forKey: "nombre")
			dict?.write(toFile: filePathUser, atomically: false)
		}
	}
	
	func userProfileFilePath() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let documentsDirectory = paths[0]
		return documentsDirectory.appending("/userProfile.plist")
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
