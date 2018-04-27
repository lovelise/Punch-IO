//
//  GroupCell.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-26.
//  Copyright © 2018 Tech. All rights reserved.
//
import Foundation
import UIKit

class GroupMemberEmployeeCell: UITableViewCell {
	
	var item: GroupMembersHoursViewModelItem? {
      didSet {
         guard let item = item as? GroupMembersHoursViewModelEmployee  else {
            return
         }
		 
		 //can set label text here
		 //nameLabel?.text = item.name
      }
   }
	
}