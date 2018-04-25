//
//  BreakDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-19.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

public class BreakDA{
    
    private var dbHelper: PunchIODatabaseHelper
    var db: OpaquePointer?
    
    init() {
        dbHelper = PunchIODatabaseHelper()
        //Pointer
        db = dbHelper.openDatabase()
    }
    
    //start addBreak fun
    func addBreak(workBreak: Break){
        //creating a pointer
        var stmt:OpaquePointer? = nil
        
        //creating a insert query
        //let addBreakQuery = "INSERT INTO Break_T(work_day_id, time_start, time_end) VALUES (?,?,?);"
        let addBreakQuery = "INSERT INTO Break_T(work_day_id, time_start) VALUES (?,?);"
        
        //prepare the query
        if sqlite3_prepare_v2(db, addBreakQuery, -1, &stmt, nil) == SQLITE_OK {
            
            //binding the parameter
            //cannot call break object dont know why 
            if sqlite3_bind_int(stmt, 1, Int32(workBreak._id)) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            //let tempTimeStart: Int32 = workBreak.getStartTimeInt32()
            
            if sqlite3_bind_int(stmt, 2,workBreak.getStartTimeInt32())  != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
//            if sqlite3_bind_int(stmt, 3, workBreak.getEndTimeInt32()) != SQLITE_OK {
//                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                print("failure binding name: \(errmsg)")
//                return
//            }
            
            
            //excuting the query and verifty it finished
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Successfully inserted row for break.")
            }else{
                print("Could not insert row for break")
            }
            
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }//end of prepare the query
        sqlite3_finalize(stmt)
        
    }//end addBreak func
    
    // select grounpMemberId from
    func getWorkdayBreaks(workDayId: Int) -> [Break] {
        var stmt: OpaquePointer?
        let query = "SELECT * FROM Break_T WHERE work_day_id = ?"
        var tempBreakList: [Break] = [Break]()
        
        if sqlite3_prepare_v2(db, query, -1,&stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [Break]()
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(workDayId)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return [Break]()
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW{
            let breakId = Int(sqlite3_column_int(stmt, 0))
            let workDayID = Int(sqlite3_column_int(stmt, 1))
            let timeStartDate = Int(sqlite3_column_int(stmt, 2))
            let timeEndDate = Int(sqlite3_column_int(stmt, 3))
            //convert integer date representations to dates
            let startDateInterval = Double(timeStartDate)
            let startDate = Date(timeIntervalSince1970: startDateInterval)
            let endDateInterval = Double(timeEndDate)
            let endDate = Date(timeIntervalSince1970: endDateInterval)
            let wda = WorkDayDA()
            let tempWorkDay = wda.getWorkDay(workDayId: workDayID)
            let tempBreak = Break(id: breakId, workDay: tempWorkDay!, timeStart: startDate, timeEnd: endDate)
            tempBreakList.append(tempBreak)
        }
        sqlite3_finalize(stmt)
        return tempBreakList
    }
    
    func getIncompleteBreak(workday: WorkDay) -> Break?{
        var stmt: OpaquePointer?
        let query = "SELECT * FROM Break_T WHERE work_day_id = ? AND time_end IS NULL"
        
        if sqlite3_prepare_v2(db, query, -1,&stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return nil
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(workday._id)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return nil
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW{
            let breakId = Int(sqlite3_column_int(stmt, 0))
            let workDayID = Int(sqlite3_column_int(stmt, 1))
            let timeStartDate = Int(sqlite3_column_int(stmt, 2))
            let timeEndDate = Int(sqlite3_column_int(stmt, 3))
            //convert integer date representations to dates
            let startDateInterval = Double(timeStartDate)
            let startDate = Date(timeIntervalSince1970: startDateInterval)
            let endDateInterval = Double(timeEndDate)
            let endDate = Date(timeIntervalSince1970: endDateInterval)
            let wda = WorkDayDA()
            let tempBreak = Break(id: breakId, workDay: workday, timeStart: startDate, timeEnd: endDate)
            sqlite3_finalize(stmt)
            return tempBreak
        }
        sqlite3_finalize(stmt)
        return nil
    }
    
    
}
