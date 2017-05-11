//
//  CPMEViewController.swift
//  apis01
//
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class CPMEViewController: UIViewController {

	@IBOutlet weak var cpmeView: UIView!
	
	@IBOutlet weak var cpmeScroll: UIScrollView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		cpmeScroll.contentSize = cpmeView.frame.size
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
