class GroupMemberViewCell: UITableViewCell {
   //@IBOutlet weak var labelGroupMember: UILabel!
   
   var item: GroupMemberViewModelItem? {
      didSet {
         guard let item = item as? GroupMemberViewModelEmployee  else {
            return
         }
         labelGroupMember.text = item.name
      }
   }
}
