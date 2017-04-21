//
//  AreasTableViewController.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/13/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit



class AreasTableViewController: UITableViewController {
	
	var arrIndex: Int = 0
	var dicc = [Int:Int]()
	
	func hexStringToUIColor(hex:String) -> UIColor {
		let cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		var rgbValue:UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var rows = 0
		
		if let path = Bundle.main.path(forResource: "categorias", ofType: "plist") {
			if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
				for item in array{
					let total = Double((item["amount_questions"] as? String!)!)
					let correct = Double((item["amount_questions_right"] as? String!)!)
					
					if total != 0 && correct!/total! < 0.7{
						rows = rows + 1
					}
				}
			}
		}
		return rows
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
		
		if let path = Bundle.main.path(forResource: "categorias", ofType: "plist") {
			if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
				var found = false
				while !found {
					let item = array[arrIndex]
					let total = Double((item["amount_questions"] as? String!)!)
					let correct = Double((item["amount_questions_right"] as? String!)!)
					
					if total != 0 && Double(correct!/total!) < 0.7 {
						cell.textLabel?.text = item["title"] as? String!
						cell.textLabel?.textColor = UIColor.white
						let hex = item["hex"] as? String!
						cell.backgroundColor = hexStringToUIColor(hex: hex!)
						found = true
						
						dicc[indexPath.row] = arrIndex
					}
					arrIndex = arrIndex + 1
				}
			}
		}
		
        return cell
    }
	
	

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("selected row \(indexPath.row)")
		var vc: UIViewController!
		if dicc[indexPath.row] == 0 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBIntroduccion") as! SolventesViewController
		} else if dicc[indexPath.row] == 1 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBPetroleo") as! PetroleoViewController
		} else if dicc[indexPath.row] == 2 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBAromaticos") as! TopicViewController
		} else if dicc[indexPath.row] == 3 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBClorados") as! CloradosViewController
		} else if dicc[indexPath.row] == 4 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBGlicoles") as! GlicolesViewController
		} else if dicc[indexPath.row] == 5 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBVerdes") as! VerdesViewController
		} else if dicc[indexPath.row] == 6 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBMeTHF") as! MeTHFViewController
		} else if dicc[indexPath.row] == 7 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBCPME") as! CPMEViewController
		} else if dicc[indexPath.row] == 8 {
			vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SBDMPU") as! DMPUViewController
		}
		
		self.navigationController?.pushViewController(vc, animated:true)
	}


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
