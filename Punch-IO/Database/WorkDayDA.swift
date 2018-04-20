//
//  WorkDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-19.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

public class WorkDayDA{
    
    private var dbHelper: PunchIODatabaseHelper
    var db: OpaquePointer?
    
    init() {
        dbHelper = PunchIODatabaseHelper()
        //Pointer
        db = dbHelper.openDatabase()
    }
    
    //start addWorkDay fun
    func addWorkDay(workDay: WorkDay){
        //creating a pointer
        var stmt:OpaquePointer? = nil
        
        //creating a insert query
        let addWorkDayQuery = "INSERT INTO Work_Day_T(group_member_id,time_start,time_end) VALUES (?,?,?);"
        
        //prepare the query
        if sqlite3_prepare_v2(db, addWorkDayQuery, -1, &stmt, nil) == SQLITE_OK {
            
            //binding
            //convert data to int
            let timeStartDate = workDay._timeStart!.timeIntervalSince1970.self
            let startTimeInteger  = Int32(timeStartDate)
            
            let timeEndDate = workDay._timeEnd!.timeIntervalSince1970.self
            let endTimeInteger = Int32(timeEndDate)
            
            sqlite3_bind_int(stmt, 1, Int32(workDay._groupMember!._id)) //group member id
            sqlite3_bind_int(stmt, 2, startTimeInteger)
            sqlite3_bind_int(stmt, 3, endTimeInteger)
            
            //excuting the query and verifty it finished
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Successfully inserted row for work day.")
            }else{
                print("Could not insert row for work day")
            }
            
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            sqlite3_finalize(stmt)
            return
        }
        sqlite3_finalize(stmt)//end of prepare the query
        
    }//end addWorkDay fun
    
    func getWorkDay(workDayId: Int) -> WorkDay? {
        var stmt: OpaquePointer?
        let query = "SELECT * FROM Work_Day_T WHERE work_day_id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return nil
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(workDayId)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return nil
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let groupMemberId = Int(sqlite3_column_int(stmt, 1))
            let timeStartDate = Int(sqlite3_column_int(stmt, 2))
            let timeEndDate = Int(sqlite3_column_int(stmt, 3))
            //convert integer date representations to dates
            let startDateInterval = Double(timeStartDate)
            let startDate = Date(timeIntervalSince1970: startDateInterval)
            let endDateInterval = Double(timeEndDate)
            let endDate = Date(timeIntervalSince1970: endDateInterval)
            //get groupmember from groupMemberId
            let gmda = GroupMemberDA()
            let tempGroupMember = gmda.getGroupMember(groupMemberId: groupMemberId)
            let tempWorkDay = WorkDay(id: workDayId, groupMember: tempGroupMember!, timeStart: startDate, timeEnd: endDate)
            sqlite3_finalize(stmt)
            return tempWorkDay
        }
        sqlite3_finalize(stmt)
        return nil
        
    }
    
    func getGroupMemberWorkdays(groupMemberId: Int) -> [WorkDay] {
        var stmt: OpaquePointer?
        let query = "SELECT * FROM Work_Day_T WHERE group_member_id = ?"
        var tempWorkDays: [WorkDay] = [WorkDay]()
        
        if sqlite3_prepare_v2(db, query, -1,&stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [WorkDay]()
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(groupMemberId)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return [WorkDay]()
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let workDayId = Int(sqlite3_column_int(stmt, 0))
            let groupMemberId = Int(sqlite3_column_int(stmt, 1))
            let timeStartDate = Int(sqlite3_column_int(stmt, 2))
            let timeEndDate = Int(sqlite3_column_int(stmt, 3))
            
            //convert integer date representations to dates
            let startDateInterval = Double(timeStartDate)
            let startDate = Date(timeIntervalSince1970: startDateInterval)
            let endDateInterval = Double(timeEndDate)
            let endDate = Date(timeIntervalSince1970: endDateInterval)
            //get groupmember from groupMemberId
            let gmda = GroupMemberDA()
            let tempGroupMember = gmda.getGroupMember(groupMemberId: groupMemberId)
            let tempWorkDay = WorkDay(id: workDayId, groupMember: tempGroupMember!, timeStart: startDate, timeEnd: endDate)
            tempWorkDays.append(tempWorkDay)
        }
        sqlite3_finalize(stmt)
        return tempWorkDays
    }
    
    func getIncompleteWorkDay(groupMember: GroupMember) -> WorkDay?{
        var stmt: OpaquePointer?
        let query = "SELECT * FROM Work_Day_T WHERE group_member_id = ? AND time_end = NULL"
        
        if sqlite3_prepare_v2(db, query, -1,&stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return nil
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(groupMember._id)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return nil
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW{
            let workDayId = Int(sqlite3_column_int(stmt, 0))
            let timeStartDate = Int(sqlite3_column_int(stmt, 2))
            let timeEndDate = Int(sqlite3_column_int(stmt, 3))
            
            //convert integer date representations to dates
            let startDateInterval = Double(timeStartDate)
            let startDate = Date(timeIntervalSince1970: startDateInterval)
            let endDateInterval = Double(timeEndDate)
            let endDate = Date(timeIntervalSince1970: endDateInterval)
            let tempWorkDay = WorkDay(id: workDayId, groupMember: groupMember, timeStart: startDate, timeEnd: endDate)
            sqlite3_finalize(stmt)
            return tempWorkDay
        }
        sqlite3_finalize(stmt)
        return nil
    }


}
