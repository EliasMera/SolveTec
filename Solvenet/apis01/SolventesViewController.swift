//
//  SolventesViewController.swift
//  apis01
//
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class SolventesViewController: UIViewController {

	@IBOutlet weak var solventesView: UIView!
	
	@IBOutlet weak var solventesScroll: UIScrollView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		solventesScroll.contentSize = solventesView.frame.size
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
