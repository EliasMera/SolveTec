//
//  MainViewController.swift
//  Solvenet
//
//  Created by Elias on 5/10/17.
//  Copyright © 2017 Elias. All rights reserved.
//

import UIKit

class MainViewController: ViewController {
    
    private var cons: [NSLayoutConstraint]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        cons = [self.btn2.heightAnchor.constraint(equalTo: self.btn1.heightAnchor),
                self.btn2.widthAnchor.constraint(equalTo: self.btn1.widthAnchor),
                self.btn3.heightAnchor.constraint(equalTo: self.btn2.heightAnchor),
                self.btn3.widthAnchor.constraint(equalTo: self.btn2.widthAnchor),
                self.btn4.heightAnchor.constraint(equalTo: self.btn3.heightAnchor),
                self.btn4.widthAnchor.constraint(equalTo: self.btn3.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(cons)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
