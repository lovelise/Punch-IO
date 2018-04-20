//
//  EmployeeDA.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-13.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation

public class Employee : CustomStringConvertible {
    //propreties
    private var id: Int
    private var firstName: String?
    private var lastName: String?
    private var pin: Int?
    private var email: String?
    private var phone: String?
    
    //constructor
//        init() {
//            //empty
//        }
    //
    init(id: Int){
        self.id = id
    }
    
    init(id: Int, firstName: String, lastName: String, pin: Int, email: String, phone: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.pin = pin
        self.email = email
        self.phone = phone
    }
    
    //getter and setter
    
    public var _id: Int{
        get{
            return self.id
        }
        set(newId){
            self.id = newId
        }
        
    }
    public var _firstName: String?{
        get{
            return self.firstName
        }set(newFirsName){
            
            self.firstName = newFirsName
        }
    }
    public var _lastName: String?{
        get{
            return self.lastName
        }set(newLastName){
            
            self.lastName = newLastName
        }
    }
    public var _pin: Int?{
        get{
            return self.pin
        }set(newPin){
            
            self.pin = newPin
        }
    }
    public var _email: String?{
        get{
            return self.email
        }set(newEmail){
            
            self.email = newEmail
        }
    }
    public var _phone: String?{
        get{
            return self.phone
        }set(newPhone){
            
            self.phone = newPhone
        }
    }
    
    //is this working??
    public var description: String {
        var first: String = "N/A"
        var last: String = "N/A"
        if let fName = self._firstName{
            first = fName
        }
        if let lName = self._lastName{
            last = lName
        }
        
        return (" #\(self._id) \(first) \(last) ")
    }
    
}

