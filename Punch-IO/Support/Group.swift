//
//  Group.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-15.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation

public class Group: CustomStringConvertible{
    
    private var id: Int
    private var name: String
    private var manager: Manager
    
    
    //constructor 
    init(id: Int, name: String, manager: Manager) {
        self.id = id
        self.name = name
        self.manager = manager
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
    
    public var _name: String{
        get{
            return self.name
        }
        set(newName){
            self.name = newName
        }
        
    }
    
    public var _manager: Manager{
        get{
            return self.manager
        }set(newManager){
            self._manager = newManager
        }
    }
    
    public var description: String {
        return "\(self.name)"
    }
    
    
}
