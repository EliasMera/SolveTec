//
//  PetroleoViewController.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/12/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class PetroleoViewController: UIViewController {

	@IBOutlet weak var petroleoView: UIView!
	
	@IBOutlet weak var petroleoScroll: UIScrollView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		petroleoScroll.contentSize = petroleoView.frame.size
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
