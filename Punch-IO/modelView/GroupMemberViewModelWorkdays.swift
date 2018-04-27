class GroupMemberViewModelWorkdays : GroupMemberViewModelItem {
    var isCollapsed = true
    var type: GroupMemberViewModelItemType {
        return .workdays
    }
    var sectionTitle: String{
        return "Workdays"
    }
    var workdays : [WorkDay]
    var workdaysCount: String {
        return String(workdays.count)
    }
    var rowCount: Int {
        return workdays.count
    }
    var workdayModelItems: [GroupMemberViewModelWorkday] {
        var workdayItems: [GroupMemberViewModelWorkday] = [GroupMemberViewModelWorkday]()
        for workday in workdays{
            workdayItems.append(GroupMemberViewModelWorkday(workday: workday))
        }
        return workdayItems
    }
    init(workdays: [WorkDay]){
        self.workdays = workdays
    }
}