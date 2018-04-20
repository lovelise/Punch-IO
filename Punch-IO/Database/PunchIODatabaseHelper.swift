//
//  PunchIODatabaseHelper.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-09.
//  Copyright © 2018 Tech. All rights reserved.
//  https://www.raywenderlich.com/167743/sqlite-swift-tutorial-getting-started

import Foundation
import SQLite3


internal class PunchIODatabaseHelper{
    
    var db: OpaquePointer?
    var path: String
    static var dropped: Bool = false
    

    init() {
        //TODO
        //create if statement to check if the database file exist or not
        
        //CREATING THE SQLIT FILE
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("PunchIO5.sqlite")
        
        path = fileURL.absoluteString
        
        //print(fileURL.absoluteString)
        
        //OPENING THE DATABASE
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        //DROP TABLE IF EXISTS
        if !PunchIODatabaseHelper.dropped{
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Employee_T;", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Manager_T;", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Group_T;", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Group_Member_T;", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Work_Day_T;", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        if sqlite3_exec(db, "DROP TABLE IF EXISTS Break_T;", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
            PunchIODatabaseHelper.dropped = true
        }
        
        //CREATING TABLES
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Employee_T(employee_id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, last_name TEXT,pin INTEGER NOT NULL, email TEXT NOT NUll, phone TEXT)", nil, nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Manager_T(manager_id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, last_name TEXT,  pin INTEGER NOT NULL, email TEXT NOT NUll, phone TEXT) ", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }

        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Group_T(group_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT UNIQUE, manager_id INTEGER NOT NULL, FOREIGN KEY (manager_id) REFERENCES Manager_T(manager_id))", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        /*
         note:
         Group_Member_T originally had a composite primary key consisting of group_id and
         employee_id, not it has a singular primary key for Work_Day_T to reference easier
         */
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Group_Member_T(group_member_id INTEGER PRIMARY KEY AUTOINCREMENT,group_id INTEGER NOT NULL, employee_id INTEGER NOT NULL, status INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (group_id) REFERENCES Group_T(group_id),FOREIGN KEY (employee_id) REFERENCES Employee_T(employee_id))", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        /*Using INTEGER to store Long value of corresponding Java Date
         * Nullable time_end for shifts in progress */
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Work_Day_T(work_day_id INTEGER PRIMARY KEY AUTOINCREMENT, group_member_id INTEGER NOT NULL, time_start INTEGER NOT NULL, time_end INTEGER, FOREIGN KEY (group_member_id) REFERENCES Group_Member_T(group_member_id))", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF  NOT EXISTS Break_T(break_id INTEGER PRIMARY KEY AUTOINCREMENT, work_day_id INTEGER NOT NULL, time_start INTEGER NOT NULL, time_end INTEGER, FOREIGN KEY (work_day_id) REFERENCES Work_Day_T (work_day_id))", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }

        
        
        //call addEmployee func

        
//        addEmployee(firstName: "John", lastName: "Black", pin: 2345, email: "johnblack@something.ca", phone: "6472059224")
//        addEmployee(firstName: "Susan", lastName: "White", pin: 1234, email: "susanwhite@something.ca", phone: "6472059245")
//        addManager(first_name: "Jeff", last_name: "lee", pin: 456, email: "jefflee@somthing.ca", phone: "6475064166")
//        addManager(first_name: "Nina", last_name: "Ma", pin: 567, email: "ninama@somthing.ca", phone: "6475064166")
//        addGroup(name: "HR",manager_id: 2)
//        addGroup(name: "IT Support",manager_id: 1)
//        addGroupMember(group_id: 1, employee_id: 2, status_: 2)
//        addGroupMember(group_id: 1, employee_id: 1)
//        addWorkDay(groupMemberId: 1, timeStart: 2018041108, timeEnd: 2018041115)
//        addBreak(workDayId: 1, timeStart: 0830, timeEnd: 0900)
    
       
        }
    
    
    deinit {
        closeDatabase()
    }
    
    func openDatabase() -> OpaquePointer?{
        var tempdb: OpaquePointer? = nil
        if sqlite3_open(self.path, &tempdb) == SQLITE_OK{
            //print("Successfully opened connection to database at \(self.path)")
            print("Successfully opened connection to database")
            return tempdb!
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            return nil
        }
    }
    
    func closeDatabase(){
        if sqlite3_close(db) == SQLITE_OK{
            //print("Successfully close connection to database at \(self.path)")
            print("Successfully close connection to database")
        }else {
            print("Unable to close database. Verify that you created the directory described " +
                "in the Getting Started section.")
        }
    }
    
        
    }//end class
    


