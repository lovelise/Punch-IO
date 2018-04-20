//
//  Break.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-15.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation

public class Break{
    private var id: Int
    private var workDay: WorkDay
    private var timeStart: Date
    private var timeEnd: Date

    init(id:Int, workDay: WorkDay, timeStart: Date, timeEnd: Date) {
        self.id = id
        self.workDay = workDay
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
    public var _workDay: WorkDay {
    get{
        return self.workDay
    }
    set(newWorkDay){
        self.workDay = newWorkDay
    }
    }
    public var _timeStart: Date {
    get{
        return self.timeStart
    }
    set(newTimeStart){
        self.timeStart = newTimeStart
    }
    }
    
    //return break start date as an Integer32 representation; includes milliseconds
    func getStartTimeInt32() -> Int32{
        if(self.timeStart.timeIntervalSince1970 == 0){
            return 0
        }
        let timeStartInterval = self._timeStart.timeIntervalSince1970 * 1000
        let timeStart = Int32(timeStartInterval)
        return timeStart
    }
    
    public var _timeEnd: Date {
    get{
        return self.timeEnd
    }
    set(newTimeEnd){
        self.timeEnd = newTimeEnd
    }
    }
    
    //return break end date as an Integer32 representation; includes milliseconds
    func getEndTimeInt32() -> Int32{
        if(self._timeEnd.timeIntervalSince1970 == 0){
            return 0
        }
        let timeEndInterval = self._timeEnd.timeIntervalSince1970 * 1000
        let timeEnd = Int32(timeEndInterval)
        return timeEnd
    }
    
    //formatting function 
}
