//
//  ViewController.swift
//  apis01
//
//  Created by Andrés Altamirano on 4/9/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var topicsView: UIView!
	@IBOutlet weak var topicsScroll: UIScrollView!
	
	@IBOutlet weak var btn0: UIButton!
	@IBOutlet weak var btn1: UIButton!
	@IBOutlet weak var btn2: UIButton!
	@IBOutlet weak var btn3: UIButton!
	@IBOutlet weak var btn4: UIButton!
	@IBOutlet weak var btn5: UIButton!
	@IBOutlet weak var btn6: UIButton!
	@IBOutlet weak var btn7: UIButton!
	@IBOutlet weak var btn8: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		topicsScroll.contentSize = topicsView.frame.size
		
		btn0.layer.cornerRadius = 10
		btn0.clipsToBounds = true
		btn1.layer.cornerRadius = 10
		btn1.clipsToBounds = true
		btn2.layer.cornerRadius = 10
		btn2.clipsToBounds = true
		btn3.layer.cornerRadius = 10
		btn3.clipsToBounds = true
		btn4.layer.cornerRadius = 10
		btn4.clipsToBounds = true
		btn5.layer.cornerRadius = 10
		btn5.clipsToBounds = true
		btn6.layer.cornerRadius = 10
		btn6.clipsToBounds = true
		btn7.layer.cornerRadius = 10
		btn7.clipsToBounds = true
		btn8.layer.cornerRadius = 10
		btn8.clipsToBounds = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

