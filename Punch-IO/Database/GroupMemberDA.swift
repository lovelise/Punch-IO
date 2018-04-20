//
//  GroupMemberDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-19.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

public class GroupMemberDA{
    
    private var dbHelper: PunchIODatabaseHelper
    var db: OpaquePointer?
    
    init() {
        dbHelper = PunchIODatabaseHelper()
        //Pointer
        db = dbHelper.openDatabase()
    }
    
    // START addGroupMember fun
    func addGroupMember(groupMember: GroupMember){
        //creating a pointer
        var stmt:OpaquePointer? = nil
        
        //creating a insert query
        let groupMemberQuery = "INSERT INTO Group_Member_T(group_id, employee_id,status) VALUES(?,?,?);"
        
        //prepare the query
        if sqlite3_prepare_v2(db, groupMemberQuery, -1, &stmt, nil) == SQLITE_OK {
            
            //binding
            sqlite3_bind_int(stmt, 1, Int32(groupMember._id))
            sqlite3_bind_int(stmt, 2, Int32(groupMember._employee._id))
//            let iStatus: Int32 = status_!
            sqlite3_bind_int(stmt, 3, Int32(groupMember._status))

            //excuting the query and verifty it finished
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Successfully inserted row for group member.")
            }else{
                print("Could not insert row for group member")
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print(errmsg)
            }
            
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            sqlite3_finalize(stmt)
            return
        }
        sqlite3_finalize(stmt)//end of prepare the query
        
    }//end addGroupMember fun
    
    //Select all group members
    func getAllGroupMembers() -> [GroupMember]{
        let query = "SELECT gm.group_member_id, gm.group_id, gm.employee_id, gm.status, g.manager_id, g.group_id, g.name FROM Group_Member_T gm INNER JOIN Group_T g ON gm.group_id = g.group_id"
        var stmt:OpaquePointer?
        var tempArrayGroupMemberList: [GroupMember] = [GroupMember]()
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [GroupMember]()
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let groupId = Int(sqlite3_column_int(stmt, 1))
            let employeeId = Int(sqlite3_column_int(stmt, 2))
            let status  = Int(sqlite3_column_int(stmt, 3))
            let managerId = Int(sqlite3_column_int(stmt, 4))
            let groupName = String(cString: sqlite3_column_text(stmt, 6))
            let tempEmployee = Employee(id:employeeId)
            let tempManager = Manager(id: managerId)
            let tempGroup = Group(id: groupId, name: groupName, manager: tempManager)
            let tempGroupMembers: GroupMember = GroupMember(id: id, group: tempGroup, employee: tempEmployee, status: status)
            tempArrayGroupMemberList.append(tempGroupMembers)
        }
        sqlite3_finalize(stmt)
        return tempArrayGroupMemberList
    }
    
    func getAllGroupMembers(groupId: Int) -> [GroupMember]{
        let query = "SELECT gm.group_member_id, gm.group_id, gm.employee_id, gm.status, g.manager_id, g.group_id, g.name FROM Group_Member_T gm INNER JOIN Group_T g ON gm.group_id = g.group_id WHERE gm.group_id = ?"
        var stmt:OpaquePointer?
        var tempArrayGroupMemberList: [GroupMember] = [GroupMember]()
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [GroupMember]()
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(groupId)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return [GroupMember]()
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let groupId = Int(sqlite3_column_int(stmt, 1))
            let employeeId = Int(sqlite3_column_int(stmt, 2))
            let status  = Int(sqlite3_column_int(stmt, 3))
            let managerId = Int(sqlite3_column_int(stmt, 4))
            let groupName = String(cString: sqlite3_column_text(stmt, 6))
            //Pressure Zone- May crash; if does, get employee iformation from query
            let eda = EmployeeDA()
            let tempEmployee = eda.getEmployee(id: employeeId)
            //
            let tempManager = Manager(id: managerId)
            let tempGroup = Group(id: groupId, name: groupName, manager: tempManager)
            let tempGroupMembers: GroupMember = GroupMember(id: id, group: tempGroup, employee: tempEmployee!, status: status)
            tempArrayGroupMemberList.append(tempGroupMembers)
        }
        sqlite3_finalize(stmt)
        return tempArrayGroupMemberList
    }
    
    func getGroupMember(groupMemberId: Int) -> GroupMember?{
        let query = "SELECT gm.group_member_id, gm.group_id, gm.employee_id, gm.status, g.manager_id, g.group_id, g.name FROM Group_Member_T gm INNER JOIN Group_T g ON gm.group_id = g.group_id WHERE gm.group_member_id = ?"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return nil
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(groupMemberId)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return nil
        }
        
            if sqlite3_step(stmt) == SQLITE_ROW{
            let id = Int(sqlite3_column_int(stmt, 0))
            let groupId = Int(sqlite3_column_int(stmt, 1))
            let employeeId = Int(sqlite3_column_int(stmt, 2))
            let status  = Int(sqlite3_column_int(stmt, 3))
            let managerId = Int(sqlite3_column_int(stmt, 4))
            let groupName = String(cString: sqlite3_column_text(stmt, 6))
            //Pressure Zone- May crash; if does, get employee iformation from query
            let eda = EmployeeDA()
            let tempEmployee = eda.getEmployee(id: employeeId)
            //
            let tempManager = Manager(id: managerId)
            let tempGroup = Group(id: groupId, name: groupName, manager: tempManager)
            let tempGroupMember: GroupMember = GroupMember(id: id, group: tempGroup, employee: tempEmployee!, status: status)
            sqlite3_finalize(stmt)
            return tempGroupMember
        }
        sqlite3_finalize(stmt)
        return nil
     }
}
