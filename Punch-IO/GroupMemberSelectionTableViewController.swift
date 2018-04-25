//
//  GroupMemberSelectionTableViewController.swift
//  Punch-IO
//
//  Created by Tech on 2018-04-23.
//  Copyright © 2018 Tech. All rights reserved.
//

import UIKit

class GroupMemberSelectionTableViewController: UITableViewController {

    @IBOutlet weak var titleItem: UINavigationItem!
    
    //TEMP DATA
    //var groupMemberNames = [String]()
    //var groupMemberIds = [Int]()
    var groupMembers = [GroupMember]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data
        
        //dummy data
        EmployeeDA().addEmployee(employee: Employee(id: 1, firstName: "Brendan", lastName: "Bernas", pin: 1234, email: "bb@gbc.com", phone: "1231231234"))
        EmployeeDA().addEmployee(employee: Employee(id: 2, firstName: "Piotr", lastName: "Grabowski", pin: 1234, email: "pg@gbc.com", phone: "1231231234"))
        ManagerDA().addManager(manager: Manager(id: 1, firstName: "Anjana", lastName: "Shah", pin: 1234, email: "ashah@georgebrown.ca", phone: "1231231234"))
        let grp = Group(id: 1, name: "Punch-IO Core", manager: ManagerDA().getManager(id: 1)!)
        GroupDA().addGroup(group: grp)
        GroupMemberDA().addGroupMember(groupMember: GroupMember(id: 1, group: grp, employee: EmployeeDA().getEmployee(id: 1)!))
         GroupMemberDA().addGroupMember(groupMember: GroupMember(id: 1, group: grp, employee: EmployeeDA().getEmployee(id: 2)!))
        
        
        /*
        groupMemberNames = ["Brendan Bernas",
                        "Piotr Grabowski",
                        "Elise Tang",
                        "Yuming Wu"]
        groupMemberIds = [5, 6, 7, 8]
        
        titleItem.title? = "PUNCH IO Group 1"
        */
        
        groupMembers = GroupMemberDA().getAllGroupMembers(groupId: 1)
        
        /*for member in groupMembers{
            groupMemberNames.append(member._employee._firstName! + " " + member._employee._lastName!)
            groupMemberIds.append(member._id)
        }*/
        
        //todo change to better name
        titleItem.title? = GroupDA().getManagersGroups(managerId: 1)[0]._name
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupMembers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = groupMembers[indexPath.row]._employee._firstName! + " " + groupMembers[indexPath.row]._employee._lastName!
        

        //set value to id of groupMember
        //cell.setValue(1, forKeyPath: "groupMemberId")
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let c = segue.destination as! GroupMemberSignInViewController
        //set groupMemberId for next Controller
        //c.groupMemberId = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.value(forKeyPath: "groupMemberId") as! Int
        //c.groupMemberId = groupMemberIds[(tableView.indexPathForSelectedRow?.row)!]
        c.groupMember = groupMembers[(tableView.indexPathForSelectedRow?.row)!]
        
        
    }
    

}
