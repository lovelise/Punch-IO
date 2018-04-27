//
//  GroupSelectionView.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-23.
//  Copyright © 2018 Tech. All rights reserved.
//

import UIKit

var selectedGroup = 0

class GroupSelectionView: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var managerGroups: [Group] = [Group]()
    @IBOutlet weak var tableGroups: UITableView!
    @IBOutlet weak var labelManagerName: UILabel!
    @IBOutlet weak var btnEmployeeSignIn: UIButton!
    @IBOutlet weak var btnViewGroup: UIButton!
    
    var signedInManagers: Manager?
    
    @IBAction func onClickEmployeeSignIn(_ sender: UIButton) {
        //let employeeSignIn = storyboard?.instantiateViewController(withIdentifier: "GroupMemberSignInTableView") as! GroupMemberSelectionTableViewSignInController
        
        let employeeSignInPage = storyboard?.instantiateViewController(withIdentifier: "GroupMemberSignInTableView") as! GroupMemberSelectionTableViewSignInController
        
        let indexPath = tableGroups.indexPathForSelectedRow
        
        if let index = indexPath?.item {
            let gmda = GroupMemberDA()
            let selectedGroupMembers = gmda.getAllGroupMembers(groupId: managerGroups[index]._id)
            employeeSignInPage.groupMembers = selectedGroupMembers
            print(selectedGroupMembers)
            print(employeeSignInPage.groupMembers)
            //self.performSegue(withIdentifier: "employeeSignIn", sender: self)
            //navigationController?.pushViewController(employeeSignIn, animated: true)
        }
    }
    
    @IBOutlet weak var onClickViewGroup: UIButton! //???
    
    @IBAction func onClickHourView(_ sender: Any) {
        //passing the group name to view employee hours
        //get the group name from Table view
        //Initi
//        let hourView = storyboard?.instantiateViewController(withIdentifier: "hourView") as! HourViewController
//
//        //1.get the selected row
//        let indexPath = tableGroups.indexPathForSelectedRow
//        let currentCell = tableGroups.cellForRow(at: indexPath!) as! UITableViewCell
//
//        let groupName = currentCell.textLabel?.text
//
//        let gda = GroupDA()
//        //let gdaId = gda.getManagersGroups(managerId: signedInManagers!._id)
//        let gmda = GroupMemberDA()
//        //put it to string pass it to next page
//        if let index = indexPath?.item {
//            let selectedGroupMembers = gmda.getAllGroupMembers(groupId: managerGroups[index]._id)
//            hourView.selectedGroup = selectedGroupMembers
//            hourView.groupName = managerGroups[index]._name
//            navigationController?.pushViewController(hourView, animated: true)
//        }
        
        //self.performSegue(withIdentifier: "viewHours", sender: self)
  
    
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGroups.delegate = self
        tableGroups.dataSource = self
        let fName = signedInManagers!._firstName!
        let lName = signedInManagers!._lastName!
        labelManagerName.text = "Welcome, \(fName) \(lName)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managerGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(managerGroups[indexPath.row]._name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroup = indexPath.row + 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "employeeSignIn" {
        
            
            let employeeSignInPage = storyboard?.instantiateViewController(withIdentifier: "GroupMemberSignInTableView") as! GroupMemberSelectionTableViewSignInController
            let gmda = GroupMemberDA()
            let indexPath = tableGroups.indexPathForSelectedRow!
            let row = indexPath.item
            employeeSignInPage.groupMembers = gmda.getAllGroupMembers(groupId: row)
 
            
            /*
            let c = segue.destination as! GroupMemberSelectionTableViewSignInController
            c.groupMembers = GroupMemberDA().getAllGroupMembers(groupId: (tableGroups.indexPathForSelectedRow?.row)!)
             */
        }
        
        if segue.identifier == "viewHours" {
            let viewHours = segue.destination as! HourViewController
            //let viewHours = storyboard?.instantiateViewController(withIdentifier: "hourView") as! HourViewController
            let indexPath = tableGroups.indexPathForSelectedRow
            let currentCell = tableGroups.cellForRow(at: indexPath!) as! UITableViewCell
            let groupName = currentCell.textLabel?.text
            let gda = GroupDA()
            let gmda = GroupMemberDA()
            if let index = indexPath?.item {
                let selectedGroupMembers = gmda.getAllGroupMembers(groupId: managerGroups[index]._id)
                viewHours.selectedGroup = selectedGroupMembers
                viewHours.groupName = managerGroups[index]._name
            }
        }
        
        
    }
    
    //didselectedrow
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//
//        let selectedGroup = tableView.cellForRow(at: indexPath)! as UITableViewCell
//
//
//    }
//    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as! UITableViewCell
//        cell.textLabel?.text =  managerGroups[indexPath.row]._name
//        return cell
//    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


