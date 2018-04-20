//
//  ViewController.swift
//  Punch-IO
//
//  Created by Tech on 2018-03-02.
//  Copyright © 2018 Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myEployee: UILabel!
   
    @IBAction func btnLogin(_ sender: UIButton) {
        print("login clicked")
    }
    
    // test the AddEmployee button
    @IBAction func btnAddEmployee(_ sender: UIButton) {
        print("add employee cliked");
    }
    //    @IBAction func btnRegister(_ sender: Any) {
//        print("cliked");
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // when protected page loaded/created, execute below statement to show the user the login view page
    override func viewDidAppear(_ animated: Bool) {

    }
}

