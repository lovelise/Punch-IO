//
//  GroupDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-19.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

public class GroupDA{
    
    private var dbHelper: PunchIODatabaseHelper
    var db: OpaquePointer?
    
    init() {
        dbHelper = PunchIODatabaseHelper()
        //Pointer
        db = dbHelper.openDatabase()
    }
    
    //addGroup start func
    func addGroup(group: Group){
        //creating a pointer
        var stmt:OpaquePointer? = nil
        
        //creating a insert query
        let groupQuery = "INSERT INTO Group_T(name,manager_id) VALUES(?,?);"
        
        //prepare the query
        if sqlite3_prepare_v2(db, groupQuery, -1, &stmt, nil) == SQLITE_OK {
            
            //binding
            let NSName = group._name as NSString
            sqlite3_bind_text(stmt, 1, NSName.utf8String, -1, nil)
            sqlite3_bind_int(stmt, 2, Int32(group._manager._id))
            
            
            //excuting the query and verifty it finished
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Successfully inserted row for group.")
            }else{
                print("Could not insert row for Group")
            }
            
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            sqlite3_finalize(stmt)
            return
        }
        sqlite3_finalize(stmt)//end of prepare the query
        
    }//end addGroup fun
    
    //get All Group
    func getAllGroups() -> [Group]{
        let query = "SELECT * FROM Group_T"
        var stmt:OpaquePointer?
        var tempArrayGroupList: [Group] = [Group]()
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [Group]()
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let manager_id = Int(sqlite3_column_int(stmt, 2))
            let tempManager: Manager = Manager(id:Int(manager_id))
            
            let intId = Int(id)
         
            
            let tempGroup: Group = Group(id: intId, name: name, manager:tempManager)
            tempArrayGroupList.append(tempGroup)
        }
        sqlite3_finalize(stmt)
        return tempArrayGroupList
    }
    
    func getManagersGroups(managerId: Int) -> [Group]{
        let query = "SELECT * FROM Group_T WHERE manager_id = ?"
        var stmt: OpaquePointer?
        var tempArrayGroupList: [Group] = [Group]()
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [Group]()
        }
        if sqlite3_bind_int(stmt, 1, Int32(managerId)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return [Group]()
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW{
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let managerId = Int(sqlite3_column_int(stmt, 2))
            let m1 = Manager(id:managerId)
            let g1 = Group(id: id, name: name, manager: m1)
            tempArrayGroupList.append(g1)
        }
        sqlite3_finalize(stmt)
        return tempArrayGroupList
    }
    
}
