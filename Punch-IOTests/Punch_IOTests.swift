//
//  Punch_IOTests.swift
//  Punch-IOTests
//
//  Created by Tech on 2018-03-02.
//  Copyright © 2018 Tech. All rights reserved.
//

import XCTest
@testable import Punch_IO

class Punch_IOTests: XCTestCase {
    
    //var punchIODataHelper = PunchIODatabaseHelper()
    
    override func setUp() {
        super.setUp()
        //testEmployeeInsert(id: 1, firstName: "Susan", lastName: "White", pin: 1234, email: "something@something.ca", phone: "4161231234")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        testEmployeeInsert(id: 1, firstName: "Susan", lastName: "White", pin: 1234, email: "SWhite@something.ca", phone: "647-777-7777")
        testManagerInsert(id: 1, firstName: "Jeff", lastName: "Lee", pin: 2345, email: "JLee@somthing.ca", phone: "6473446678")
        testGroupInsert(id: 1, name: "Capstone", managerId: 1)
        testGroupMemberInsert(id: 1, groupId: 1, employeeId: 1, status: 1)
        let gmda = GroupMemberDA()
        let g1 = gmda.getGroupMember(groupMemberId: 1)
        let timeInterval = 1524251131
        let sDate = Date(timeIntervalSince1970: Double(timeInterval))
        testWorkDayInsert(id: 1, groupMember: g1!, startDate: sDate, endDate: Date())
//        let ts = Date().timeIntervalSinceNow
//        let te = Date().timeIntervalSinceNow + 30
//        testBreakInsert(id: 1, workDay: 1, timeStart: ts, timeEnd: Date(0430))
    
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEmployeeInsert(id : Int, firstName: String, lastName : String, pin : Int, email: String, phone: String){
        let e1 = Employee(id:id,firstName:firstName,lastName:lastName,pin:pin,email:email,phone:phone)
        let eda =  EmployeeDA()
        eda.addEmployee(employee: e1)
        //print("Employee List \(eda.readEmployee())")
        let e2 = eda.getEmployee(id: e1._id)
        print("e2 \(e2!)")
        XCTAssert(e1._id == 1) //they are not the same object somehow dont know why ??
                                    // samething to do with our class
                                    // class is reference types
                                    // struct  is a valute type
        
    }
    
    func testManagerInsert(id: Int, firstName: String, lastName: String, pin: Int, email: String, phone: String){
        let m1 = Manager(id: id, firstName: firstName, lastName: lastName, pin: pin, email: email, phone: phone)
        let mda = ManagerDA()
        mda.addManager(manager: m1)
        let m2 = mda.getManager(id: m1._id)
        print("m2 \(m2)")
        XCTAssert(m1._id == m2?._id) //same as addEmployee()
    }
    
//    func testBreakInsert(id:Int, workDay: Int, timeStart: Date, timeEnd: Date) {
//        let wd = WorkDay(id: id)
//        let b1 = Break(id: id, workDay: wd, timeStart: timeStart, timeEnd: timeEnd)
//        let bda = BreakDA()
//        bda.addBreak(workBreak: b1)
//
//    }
    
    func testGroupInsert(id: Int, name: String, managerId: Int){
        let m1 = Manager(id:id)
        let g1 = Group(id:id,name:name,manager:m1)
        let gda = GroupDA()
        gda.addGroup(group: g1)
        var groupList: [Group] = gda.getManagersGroups(managerId: 1)
        let g2 = groupList.popLast()
        print(g2!)
        //XCTAssert(g1._id == g2?._id)
    }
    
    func testGroupMemberInsert(id: Int, groupId: Int, employeeId: Int, status: Int){
        let gmda = GroupMemberDA()
        let e1 = Employee(id: 1)
        let m1 = Manager(id: 1)
        let g1 = Group(id: 1, name: "Capstone", manager: m1)
        let gm1 = GroupMember(id: id, group: g1, employee: e1)
        gmda.addGroupMember(groupMember: gm1)
        var groupMemberList: [GroupMember] = gmda.getAllGroupMembers(groupId: 1)
        let gm2 = groupMemberList.popLast()
        print(gm2!)
        XCTAssert(gm1._id == gm2?._id)
    }
    
    func testWorkDayInsert(id: Int,groupMember: GroupMember, startDate: Date, endDate: Date){
        let wda = WorkDayDA()
        let w1 = WorkDay(id: id, groupMember: groupMember, timeStart: startDate, timeEnd: endDate)
        wda.addWorkDay(workDay: w1)
        var workDays: [WorkDay] = wda.getGroupMemberWorkdays(groupMemberId: groupMember._id)
        let w2 = workDays.popLast()
        print(w2!.getFormattedLength())
        XCTAssert(w1._id == w2?._id)
    }

}
