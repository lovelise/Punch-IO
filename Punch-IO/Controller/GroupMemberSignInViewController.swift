//
//  GroupMemberSignInViewController.swift
//  Punch-IO
//
//  Created by Tech on 2018-04-23.
//  Copyright © 2018 Tech. All rights reserved.
//

import UIKit

class GroupMemberSignInViewController: UIViewController {
    
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblWorkInfo: UILabel!
    //@IBOutlet weak var lblWorkInfo: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnPunchIn: UIButton!
    @IBOutlet weak var btnPunchOut: UIButton!
    @IBOutlet weak var btnBreakIn: UIButton!
    @IBOutlet weak var btnBreakOut: UIButton!
    @IBAction func onClickBack(_ sender: Any) {
//        let groupSelection = storyboard?.instantiateViewController(withIdentifier: "GroupSelectionView") as! GroupSelectionView
//        groupSelection.signedInManagers = Manager(id: 1)
//        navigationController?.pushViewController(groupSelection, animated: true)
    }
    
    var groupMember: GroupMember? = nil
    var workDay: WorkDay? = nil
    var workBreak: Break? = nil
    
    var timer = Timer()
    
    let workDayDA = WorkDayDA()
    let breakDA = BreakDA()
    
    enum LoadType {
        case NoLoad
        case BadLoad
        case NewWorkDay
        case WorkDayInProgress
        //case WorkDayInProgressWithBreak
    }
    var loadType = LoadType.NoLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true);
        
        //load controller based on groupMember WorkDay status
        //(not in current work day)
            //- option to start
        //(in current work day)
            //- option to go break, option to end work day
        //(in current work day + work day break)
            //- option to end break, option to end work day
        
        
        //lblGroupMemberName.text = String(groupMemberId)
        
        //get group member
        
        
        if groupMember != nil{
            lblEmployeeName.text = (groupMember?._employee._firstName!)! + " " + (groupMember?._employee._lastName!)!
            let workday = WorkDayDA().getIncompleteWorkDay(groupMember: groupMember!)
            if workday == nil || workday?._timeEnd?.timeIntervalSince1970 != 0{
                //no incomplete workday in progress
                loadType = .NewWorkDay
            }else{
                loadType = .WorkDayInProgress
                workDay = workday
                
                /*
                if let workbreak = breakDA.getIncompleteBreak(workday: workday!){
                    workBreak = workbreak
                    loadType = .WorkDayInProgressWithBreak
                }
                */
                
            }
        }
        //make sure load type is not bad
        switch loadType {
        case .NoLoad:
            //load default instructions
            prepForInfo()
            break
        case .NewWorkDay:
            prepForNewWorkDay()
            break
        case .WorkDayInProgress:
            //load workday in progress stuff
            prepForWorkDayInProgress()
            break
        /*case .WorkDayInProgressWithBreak
            prepForWorkDayInProgress()
            break;*/
        default:
            //show error
            print("bad load has occured")
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepForInfo(){
        btnBack.isEnabled = false
        btnPunchIn.isEnabled = false
        btnPunchOut.isEnabled = false
        btnBreakIn.isEnabled = false
        btnBreakOut.isEnabled = false
        lblEmployeeName.text = ""
        lblDescription.text = "Welcome! Please select your name on the left"
    }
    
    func prepForNewWorkDay(){
        btnBack.isEnabled = true
        btnPunchIn.isEnabled = true
        btnPunchOut.isEnabled = false
        btnBreakIn.isEnabled = false
        btnBreakOut.isEnabled = false
        lblEmployeeName.text = groupMember!._employee._firstName! + " " + groupMember!._employee._lastName!
        lblDescription.text = "Welcome! To start a work day, select punch in!"
    }
    
    func prepForNewWorkDayAfterDayEnd(){
        loadType = .NewWorkDay
        prepForNewWorkDay()
        lblDescription.text = "Successfully ended work day, you may check in to start another work day."
        lblWorkInfo.text = lblWorkInfo.text! + "\nEnded at: " + (workDay?.getFormattedTimeEnd())!
        lblWorkInfo.text = lblWorkInfo.text! + "\nLength: \((workDay?.getFormattedLength())!)"
    }
    
    func prepForWorkDayInProgress(){
        loadType = .WorkDayInProgress
        btnBack.isEnabled = true
        btnPunchIn.isEnabled = false
        btnPunchOut.isEnabled = true
        btnBreakIn.isEnabled = true
        btnBreakOut.isEnabled = false
        lblEmployeeName.text = groupMember!._employee._firstName! + " " + groupMember!._employee._lastName!
        lblDescription.text = "You are punched in, you may choose to check out for the day"
        lblWorkInfo.text = "Started at: \(workDay!.getFormattedTimeStart())"
    }
    
    /*func prepForWorkDayInProgressWithBreak(){
        prepForWorkDayInProgress()
        
    }*/
    
    @IBAction func onClickPunchIn(_ sender: Any) {
        //create work day in DB with timeStart as now ans timeEnd as lowest value
        let wda = WorkDayDA()
        workDay = WorkDay(id: -1,
                          groupMember: groupMember!,
                          timeStart: Date(),
                          timeEnd: Date(timeIntervalSince1970: TimeInterval(exactly: 0)!)
            )
        wda.addWorkDay(workDay: workDay!)
        //must get incomplete workday to update old workday, otherwise we do not have the new row's id in the db
        workDay = wda.getIncompleteWorkDay(groupMember: groupMember!)
        prepForWorkDayInProgress()
    }
    
    @IBAction func onClickPunchOut(_ sender: Any) {
        workDay?._timeEnd = Date()
        WorkDayDA().updateWorkDayEndTime(workDay: workDay!)
        prepForNewWorkDayAfterDayEnd()
    }
    
    //removing this function
    @IBAction func onClickBreakIn(_ sender: Any) {
        var workBreak = Break(id: -1, workDay: workDay!, timeStart: Date(), timeEnd: nil)
        BreakDA().addBreak(workBreak: workBreak)
        //lblWorkInfo.text = lblWorkInfo.text! + "\nBreak in: \(workBreak.getFormattedTimeStart())"
    }
    
    @objc func updateTimeLabel(){
        if(loadType == LoadType.WorkDayInProgress){
            let now = Date().timeIntervalSince1970
            let diff = now - (workDay?._timeStart?.timeIntervalSince1970)!
            let ti = NSInteger(diff)
            let seconds = ti % 60
            let minutes = (ti / 60) % 60
            let hours = (ti / 3600)
            let formattedLength = NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds) as String
            lblTimer.text = formattedLength
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let groupSelection = segue.destination as! GroupSelectionView
        //let selectedManagerIndex = GroupDA().getAllGroups()[selectedGroup]._manager._id
        let selectedManagerIndex = GroupMemberDA().getGroupMember(groupMemberId: (groupMember?._id)!)?._group._manager._id
        groupSelection.signedInManagers = ManagerDA().getManager(id: selectedManagerIndex!)
        groupSelection.managerGroups = GroupDA().getManagersGroups(managerId: selectedManagerIndex!)
    }

}

