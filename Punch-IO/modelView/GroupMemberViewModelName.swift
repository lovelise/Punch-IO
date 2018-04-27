class GroupMemberViewModelName : GroupMemberViewModelItem {
    var isCollapsed = true
    var type: GroupMemberViewModelItemType {
        return .name
    }
    var sectionTitle: String {
        return "Group Hours"
    }
    var employeeName: String
    
    init(employeeName: String){
        self.employeeName = employeeName
    }
}