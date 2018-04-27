//
//  GroupSelectTableViewController.swift
//  Punch-IO
//
//  Created by Tech on 2018-03-26.
//  Copyright © 2018 Tech. All rights reserved.
//
import UIKit

class GroupHoursTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[indexPath.section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = items[indexPath.section]
		switch item.type {
			case .name:
                if let cell = tableView.dequeueReusableCell(withIdentifier: GroupMemberEmployeeCell.indentifier, for: indexPath) as? GroupMemberEmployeeCell {
                cell.item = item
                return cell
                }
            case .workdays: {
                if let cell = tableView.dequeueReusableCell(withIdentifier: WorkdaysCell.identifier, for: indexPath) as? WorkdaysCell {
                cell.item = item
                return cell
                }
            }
            case .workday:
                if let cell = tableView.dequeueReusableCell(withIdentifier: WorkdayCell.identifier, for: indexPath) as? WorkdayCell {
                cell.item = item
                return cell
                }
		}
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      switch items[indexPath.section].type {
      /*
          case .name:
                
                }
            case .workdays: {
               
                }
            case .workday:
                
                }
                */
        }
    }

}