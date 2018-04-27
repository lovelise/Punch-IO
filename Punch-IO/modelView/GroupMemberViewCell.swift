class GroupMemberViewCell: UITableViewCell {
   //@IBOutlet weak var labelGroupMember: UILabel!
   
   var item: GroupMemberViewModelItem? {
      didSet {
         // cast the ProfileViewModelItem to appropriate item type
         guard let item = item as? GroupMemberViewModelItem  else {
            return
         }
         labelGroupMember.text = item.name
      }
   }
}