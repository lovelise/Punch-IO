class GroupMembersHoursViewModel : NSObject{
    var items = [GroupMemberViewModelItem]()
    var groupMembers: [GroupMember] = [GroupMember]()
    
    override init() {
      super.init()
      
      for groupMember in groupMembers{
          if let fName = groupMember._employee._firstName, let lName = groupMember._employee._lastName{
          //get workday da to populate workday 
              let groupMemberItem = GroupMemberViewModelName(employeeName: "\(fName) \(lName) - 3 workdays")
              items.append(groupMemberItem)
            }
          }
      }
}

extension GroupMembersHoursViewModel: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return items.count
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items[section].rowCount
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   // we will configure the cells here
   }
}