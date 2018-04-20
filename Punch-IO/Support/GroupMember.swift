//
//  GroupMember.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-16.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation

public class GroupMember: CustomStringConvertible{
    
    private var id: Int
    private var group: Group
    private var employee: Employee
    private var status: Int
    private var workDayOrBreakStatus: Int = 0
    //why public and what for
    public static var PUNCHED_OUT: Int = 0
    public static var PUNCHED_IN: Int = 1
    public static var ON_BREAK: Int = 2
    public static var STATUS_ACTIVE: Int = 1
    public static var STATUS_INACTIVE: Int = 2
    
    init(id: Int, group: Group, employee: Employee) {
        self.id = id
        self.group = group
        self.employee = employee
        status = GroupMember.STATUS_ACTIVE
    }
    
    init(id: Int, group: Group, employee: Employee, status: Int) {
        self.id = id
        self.group = group
        self.employee = employee
        self.status = status
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
    
    public var _group: Group{
        get{
            return self.group
        }
        set(newGroup){
            self.group = newGroup
        }
    }
    
    public var _employee: Employee {
        get{
            return self.employee
        }
        set(newEmployee){
            self.employee = newEmployee
        }
    }
    
    
    public var _status: Int{
        get{
            return self.status
        }
        set(newStatus){
            self.status = newStatus
        }
    }
    
    public var _workDayOrBreakStatus: Int{
    get{
        return self.workDayOrBreakStatus
    }
    set(newWorkDayOrBreakStatus){
        self.workDayOrBreakStatus = newWorkDayOrBreakStatus
        }
    }
    
    //toString()????
    public var description: String{
    //        right???
        return "\(employee)"
    }
    
}
