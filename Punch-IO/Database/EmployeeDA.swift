//
//  EmployeeDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-16.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

public class EmployeeDA{
    
    private var dbHelper: PunchIODatabaseHelper
    var db: OpaquePointer?
    
    init() {
        dbHelper = PunchIODatabaseHelper()
        //Pointer
        db = dbHelper.openDatabase()
    }
    
    
     func addEmployee(employee: Employee){
        //creating a pointer
        var stmt: OpaquePointer? = nil
        var pin: Int32?
        
        //the insert query into Employee_T
        let employeeString = "INSERT INTO Employee_T  (first_name, last_name, pin, email, phone) VALUES (?, ?, ?, ?, ?);"
    
        //preparing the query
        if sqlite3_prepare_v2(db, employeeString, -1, &stmt, nil) != SQLITE_OK{
                        let errmsg = String(cString: sqlite3_errmsg(db)!)
                        print("error preparing insert: \(errmsg)")
                        print("cannot preparing insert statement in insert new employee.")
                        return
        }
        
            if let tempFirstName = employee._firstName{
                employee._firstName = tempFirstName
            }else{
                employee._firstName = ""
            }
            if let tempLastName = employee._lastName{
                employee._lastName = tempLastName
            }else{
                employee._lastName = ""
            }
            if let tempPin = employee._pin{
                pin = Int32(tempPin)
            }else{
                pin = nil
            }
            if let tempEmail = employee._email{
                employee._email = tempEmail
            }else{
                employee._email = ""
            }
            if let tempPhone = employee._phone{
                employee._phone = tempPhone
            }else{
                employee._phone = ""
            }
            
            let NSfirstName = employee._firstName! as NSString
            let NSlastName = employee._lastName! as NSString
            let NSEmail = employee._email! as NSString
            let NSPhone = employee._phone! as NSString

            
            //binding the parameters
            if sqlite3_bind_text(stmt, 1,NSfirstName.utf8String, -1, nil) == SQLITE_OK {
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
            if sqlite3_bind_text(stmt, 2, NSlastName.utf8String, -1, nil) == SQLITE_OK {
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
            if sqlite3_bind_int(stmt, 3, pin!) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }else{
            }
            
            if sqlite3_bind_text(stmt, 4, NSEmail.utf8String, -1, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }else{
            }
            
            if sqlite3_bind_text(stmt, 5, NSPhone.utf8String, -1, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }else{
            }
            
            //excuting the query
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("Successfully inserted employee row.")
            }else{
                print("Could not insert employee row.")
            }
        
        sqlite3_finalize(stmt)
    }//addEmploye end func
    
    func getAllEmployees() -> [Employee]{
        let query = "SELECT * FROM Employee_T"
        var stmt:OpaquePointer?
        var tempArrayEmployeeList: [Employee] = [Employee]()
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return [Employee]()
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let firstName = String(cString: sqlite3_column_text(stmt, 1))
            let lastName = String(cString: sqlite3_column_text(stmt, 2))
            let pin = sqlite3_column_int(stmt, 3)
            let email = String(cString: sqlite3_column_text(stmt, 4))
            let phone = String(cString: sqlite3_column_text(stmt, 5))
            
            let intId: Int = Int(id)
            let intPin: Int = Int(pin)
            
            
            let tempE: Employee = Employee(id: intId, firstName:firstName, lastName: lastName, pin: intPin, email:email,phone: phone)
            tempArrayEmployeeList.append(tempE)
        }
        sqlite3_finalize(stmt)
        return tempArrayEmployeeList
    }
    
    
    //select one employee
    func getEmployee(id: Int) -> Employee?{
        let query = "SELECT employee_id, first_name, last_name, pin, email, phone FROM Employee_T WHERE employee_id = ?"
        var stmt:OpaquePointer?
        var tempEmployee: Employee? = nil
        
        //preparing the query
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing get: \(errmsg)")
            return nil //return empty employee object
        }
        //binding the parameters
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing : \(errmsg)")
            return nil
        }
            if sqlite3_step(stmt) == SQLITE_ROW{
                let employeeId = Int(sqlite3_column_int(stmt, 0))
                print(employeeId)
                let firstName = String(cString: sqlite3_column_text(stmt, 1))
                let lastName = String(cString: sqlite3_column_text(stmt, 2))
                let pin = Int(sqlite3_column_int(stmt, 3))
                let email = String(cString: sqlite3_column_text(stmt, 4))
                let phone = String(cString: sqlite3_column_text(stmt, 5))
                
                tempEmployee = Employee(id:employeeId,firstName:firstName,lastName:lastName,pin:pin,email:email,phone:phone)
                sqlite3_finalize(stmt)
                return tempEmployee
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error on step : \(errmsg)")
        }
        sqlite3_finalize(stmt)
        return nil
        
    }//end of add select function

}//end of class
