//
//  WorkDay.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-16.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation

public class WorkDay{
    
    private var id: Int
    private var groupMember: GroupMember?
    private var timeStart: Date?
    private var timeEnd: Date?
    
    init(id:Int) {
        self.id = id
    }
    
    init(id: Int, groupMember: GroupMember, timeStart: Date, timeEnd: Date?) {
        self.id = id
        self.groupMember = groupMember
        self.timeStart = timeStart
        self.timeEnd = timeEnd
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
    public var _groupMember: GroupMember? {
    get{
        return self.groupMember
    }
    set(newGroupMember){
        self.groupMember = newGroupMember
    }
    }
    
    public var _timeStart: Date?{
    get{
        return self.timeStart
    }
    set(newTimeStart){
        self.timeStart = newTimeStart
    }
    }
    
    public var _timeEnd: Date?{
    get{
        return self.timeEnd
    }
    set(newTimeEnd){
        self.timeEnd = newTimeEnd
    }
    }
    
    func getTimeLength() -> Int32{
        if self._timeEnd == nil{
            return 0
        }
        let timeStartDate = self._timeStart!.timeIntervalSince1970.self
        let startTimeInteger  = Int32(timeStartDate)
        
        let timeEndDate = self._timeEnd!.timeIntervalSince1970.self
        let endTimeInteger = Int32(timeEndDate)
        return endTimeInteger - startTimeInteger
    }
    
    func getFormattedLength() -> NSString {
            let ti = NSInteger(getTimeLength())
            let seconds = ti % 60
            let minutes = (ti / 60) % 60
            let hours = (ti / 3600)
            return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    func getFormattedTimeStart() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return "\(df.string(from: self._timeStart!))"
    }
    
    func getFormattedTimeEnd() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return "\(df.string(from: (self._timeEnd)!))"
    }
    
    
    
}
