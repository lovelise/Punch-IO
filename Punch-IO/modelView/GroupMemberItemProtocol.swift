enum GroupMemberViewModelItemType {
    case name
    case workday
    case workdays
    case breaks
    case employeeHours
}

protocol GroupMemberViewModelItem {
    var type: GroupMemberViewModelItemType {get}
    var rowCount: Int {get}
    var sectionTitle: String {get}
    var isCollapsible: Bool {get}
    var isCollapsed: Bool { get set }
}

extension GroupMemberViewModelItem{
    var rowCount: Int {
        return 1
    }
    var isCollapsible: Bool {
      return true
   }
}