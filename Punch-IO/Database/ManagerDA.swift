//
//  ManagerDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-16.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

public class ManagerDA{
    
    private var dbHelper: PunchIODatabaseHelper
    var db: OpaquePointer?

    init() {
    dbHelper = PunchIODatabaseHelper()
    db = dbHelper.openDatabase()
    }
    
    //addManager start func
    func addManager(manager: Manager){
        //creating a pointer
        var stmt:OpaquePointer? = nil
        var pin: Int32?
        
        //creating a insert query
        let managerQuery = "INSERT INTO Manager_T(first_name, last_name,  pin, email, phone) VALUES (?,?,?,?,?);"
        if let tempFirstName = manager._firstName{
            manager._firstName = tempFirstName
        }else{
            manager._firstName = ""
        }
        if let tempLastName = manager._lastName{
            manager._lastName = tempLastName
        }else{
            manager._lastName = ""
        }
        if let tempPin = manager._pin{
            pin = Int32(tempPin)
        }else{
            pin = nil
        }
        if let tempEmail = manager._email{
            manager._email = tempEmail
        }else{
            manager._email = ""
        }
        if let tempPhone = manager._phone{
            manager._phone = tempPhone
        }else{
            manager._phone = ""
        }
        
        //prepare the query
        if sqlite3_prepare_v2(db, managerQuery, -1, &stmt, nil) == SQLITE_OK {
            //binding
            let NSfirstName = manager._firstName! as NSString
            let NSlastName = manager._lastName! as NSString
            let NSEmail = manager._email! as NSString
            let NSPhone = manager._phone! as NSString

            
            sqlite3_bind_text(stmt, 1, NSfirstName.utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, NSlastName.utf8String, -1, nil)
            sqlite3_bind_int(stmt, 3, pin!)
            sqlite3_bind_text(stmt, 4, NSEmail.utf8String, -1, nil)
            sqlite3_bind_text(stmt, 5, NSPhone.utf8String, -1, nil)
            
            
            //excuting the query and verifty it finished
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Successfully inserted row for manager table.")
            }else{
                print("Could not insert row for manager table")
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print(errmsg)
            }
            
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }//end of prepare the query
        
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
    }//end addManager fun
    
    //get All Manager
    func getAllManager() -> [Manager]{
        let query = "SELECT * FROM Manager_T"
        var stmt:OpaquePointer?
        var tempArrayManagerList: [Manager] = [Manager]()
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [Manager]()
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let firstName = String(cString: sqlite3_column_text(stmt, 1))
            let lastName = String(cString: sqlite3_column_text(stmt, 2))
            let pin = sqlite3_column_int(stmt, 3)
            let email = String(cString: sqlite3_column_text(stmt, 4))
            let phone = String(cString: sqlite3_column_text(stmt, 5))
            
            let intId = Int(id)
            let intPin = Int(pin)
            
            let tempM: Manager = Manager(id: intId, firstName:firstName, lastName: lastName, pin: intPin, email: email,phone: phone)
            tempArrayManagerList.append(tempM)
        }
        sqlite3_finalize(stmt)
        return tempArrayManagerList
    }
    
    //select only one manager
    func getManager(id: Int) -> Manager? {
        let query = "SELECT manager_id, first_name, last_name, pin, email, phone FROM Manager_T WHERE manager_id = ?"
        var stmt:OpaquePointer?
        //var tempManager: Manager = Manager() //an array??
        
        //preparing the query
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return nil// what do I return here??
        }
        
        //let int32Id: Int32 = Int32(id)
        //binding parameters
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id: \(errmsg)")
            return nil// what do I return here??
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW{
            let managerId = Int(sqlite3_column_int(stmt, 0))
            let firstName = String(cString: sqlite3_column_text(stmt, 1))
            let lastName = String(cString: sqlite3_column_text(stmt, 2))
            let pin = Int(sqlite3_column_int(stmt, 3))
            let email = String(cString: sqlite3_column_text(stmt, 4))
            let phone = String(cString: sqlite3_column_text(stmt, 5))
            let m1 = Manager(id: managerId, firstName: firstName, lastName: lastName, pin: pin, email: email, phone: phone)
            sqlite3_finalize(stmt)
            return m1
        }
        sqlite3_finalize(stmt)
        return nil
    }
}
