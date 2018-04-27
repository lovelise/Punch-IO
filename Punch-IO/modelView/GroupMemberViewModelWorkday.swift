class GroupMemberViewModelWorkday : GroupMemberViewModelItem {
    var isCollapsed = true
    var type: GroupMemberViewModelItemType {
        return .workday
    }
    var workday: WorkDay
    var sectionTitle: String{
        return "\(getFormattedDateMedium(date: workday._timeStart!)) - \(workday.getFormattedLength())"
    }
    var timeStart: String{
        return getFormattedDateTime(date: workday._timeStart!)
    }
    var timeEnd: String{
        return getFormattedDateTime(date: workday._timeEnd!)
    }
    
    var timeLength: NSString{
        let timeLengthString = workday.getFormattedLength()
        return timeLengthString
    }
    
    var rowCount: Int {
        return 3
    }
    
    init(workday : WorkDay){
        self.workday = workday
    }
    
    func getFormattedDateMedium(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return (dateFormatter.string(from: date))
    }
    func getFormattedDateTime(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        return (dateFormatter.string(from: date))
    }
}