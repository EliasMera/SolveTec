//
//  GlicolesViewController.swift
//  apis01
//
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class GlicolesViewController: UIViewController {

	@IBOutlet weak var glicolesView: UIView!
	
	@IBOutlet weak var glicolesScroll: UIScrollView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		glicolesScroll.contentSize = glicolesView.frame.size
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
