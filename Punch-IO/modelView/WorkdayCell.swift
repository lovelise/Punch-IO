//
//  GroupCell.swift
//  Punch-IO
//
//  Created by Elise Tang on 2018-04-26.
//  Copyright © 2018 Tech. All rights reserved.
//
import Foundation
import UIKit

class WorkdayCell: UITableViewCell {
	
	@IBOutlet weak var labelTimeStart: UILabel!
	@IBOutlet weak var labelTimeEnd: UILabel!
	@IBOutlet weak var labelTimeLength: UILabel!
	
	var item: GroupMembersHoursViewModelWorkdayItem? {
      didSet {
         guard let item = item as? GroupMemberViewModelWorkday  else {
            return
         }
         labelTimeStart?.text = item.timeStart
         labelTimeEnd?.text = item.timeEnd
		 labelTimeLength?.text = item.timeLength
      }
   }
	
}