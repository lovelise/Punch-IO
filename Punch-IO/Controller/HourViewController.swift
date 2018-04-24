//
//  HourViewController.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-23.
//  Copyright © 2018 Tech. All rights reserved.
//

import UIKit

class HourViewController: UIViewController{

    //passing is to group object then  groupmember
    
    var selectedGroup: [GroupMember]?
    var groupName: String = "GROUP NAME"
    
    @IBOutlet weak var lblGroupTitle: UILabel!
    @IBOutlet weak var lblTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblGroupTitle.text = "Work Hours For \(groupName.capitalized)"
        lblTextView.text = "Group Hours for \(groupName) are displayed below: \n"
        for groupMember in selectedGroup!{
            lblTextView.text.append("\(groupMember._employee._firstName!) \(groupMember._employee._lastName!) \nWorkdays:\n")
            let wda = WorkDayDA()
            for workday in wda.getGroupMemberWorkdays(groupMemberId: groupMember._id){
                lblTextView.text.append("TIME START: \(workday._timeStart!) \t\t TIME END \(workday._timeEnd!) \t Total time:\(workday.getFormattedLength())")
                /*
                for workBreak in bda.getWorkdayBreaks(workDayId: workday._id){
                    lblTextView.text.append("TIME START: \(workBreak._timeStart) \t\t TIME END \(workBreak._timeEnd) \t \(workBreak.getFormattedLength())")
                }
 */
            }
            lblTextView.text.append("\n\n")
        }
        // Do any additional setup after loading the view.
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
