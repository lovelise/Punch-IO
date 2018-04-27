class GroupMemberViewModelEmployee : GroupMemberViewModelItem {
    var isCollapsed = true
    var type: GroupMemberViewModelItemType {
        return .employeeHours
    }
    var sectionTitle: String {
        return "\(self.groupMember._employee._firstName!) \(self.groupMember._employee._lastName!)"
    }
    var groupMemberViewModelWorkdays : GroupMemberViewModelWorkdays{
        //get workdays from workday da
        let staticWorkdays : [WorkDay] = [WorkDay(id: 1, groupMember: groupMember, timeStart: Date(), timeEnd: Date()),
        WorkDay(id: 2, groupMember: groupMember, timeStart: Date(), timeEnd: Date()),
        WorkDay(id: 3, groupMember: groupMember, timeStart: Date(), timeEnd: Date())]
        return GroupMemberViewModelWorkdays(workdays: staticWorkdays)
    }
    var groupMember: GroupMember
    init(groupMember: GroupMember){
        self.groupMember = groupMember
    }
}