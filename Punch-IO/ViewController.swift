//
//  ViewController.swift
//  Punch-IO
//
//  Created by Tech on 2018-03-02.
//  Copyright © 2018 Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textManagerPassword: UITextField!
    @IBOutlet weak var textManagerId: UITextField!
    @IBAction func btnLogin(_ sender: UIButton) {
        let managerIdInput: String = textManagerId.text!
        let managerPassInput = textManagerPassword.text!
        let mda = ManagerDA()
        mda.addManager(manager: Manager(id: 1, firstName: "Jeff", lastName: "Lee", pin: 1234, email: "something@something.ca", phone: "4161231234"))
        if managerIdInput.isEmpty{
            print("ID cannot be empty")
            textManagerId.textInputView.backgroundColor = UIColor.red
        }
        if managerPassInput.isEmpty{
            print("Password cannot be empty")
            textManagerPassword.textInputView.backgroundColor = UIColor.red
            return
        }
        
        if let mId = Int(managerIdInput), let mPass = Int(managerPassInput){
            if let tempManager: Manager = mda.getManager(id: mId){
                if tempManager._id == mId && tempManager._pin == mPass{
                    
                    let groupSelection = storyboard?.instantiateViewController(withIdentifier: "GroupSelectionView") as! GroupSelectionView
                    
                    //dump data
                    let gda = GroupDA()
                    let g1 = Group(id: 1, name: "Capstone", manager: tempManager)
                    let g2 = Group(id: 2, name: "Accounting", manager: tempManager)
                    let g3 = Group(id: 3, name: "Accounting 2", manager: tempManager)
                    let e1 = Employee(id: 1, firstName: "Brendan", lastName: "Bernas", pin: 1234, email: "bb@georgebrown.ca", phone: "4161231234")
                    let e2 = Employee(id: 2, firstName: "Piotr", lastName: "Grabowski", pin: 1234, email: "pg@georgebrown.ca", phone: "4161231234")
                    let gm1 = GroupMember(id: 1, group: g1, employee: e1)
                    let gm2 = GroupMember(id: 2, group: g1, employee: e2)
                    let eda = EmployeeDA()
                    let gmda = GroupMemberDA()
                    eda.addEmployee(employee: e1)
                    eda.addEmployee(employee: e2)
                    gmda.addGroupMember(groupMember: gm1)
                    gmda.addGroupMember(groupMember: gm2)
                    gda.addGroup(group: g1)
                    gda.addGroup(group: g2)
                    gda.addGroup(group: g3)
                    let wda = WorkDayDA()
                    let w1 = WorkDay(id: 1, groupMember: gm1, timeStart: Date(), timeEnd: Date())
                    let w2 = WorkDay(id: 1, groupMember: gm1, timeStart: Date(), timeEnd: Date())
                    wda.addWorkDay(workDay: w1)
                    wda.addWorkDay(workDay: w2)
                    //seagway to other page
                    groupSelection.managerGroups =  gda.getManagersGroups(managerId: mId)
                    
                    groupSelection.signedInManagers = tempManager
                    navigationController?.pushViewController(groupSelection, animated: true)
                }
            }
        }
    }

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

