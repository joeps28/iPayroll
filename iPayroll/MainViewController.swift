//
//  ViewController.swift
//  iPayroll
//
//  Created by Joel Pineiro on 1/11/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let menuLauncher = MenuLauncher()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "iPayroll"
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showMenu(_ sender: Any) {
        menuLauncher.showMenu()
    }


}

