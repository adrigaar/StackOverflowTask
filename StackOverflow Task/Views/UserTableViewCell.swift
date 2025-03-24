import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    
    func setup(fromUser user: User) {
        self.nameLabel.text = user.name
        self.repLabel.text = String(user.rep)
        self.followLabel.text = user.isFollowed ? "Unfollow" : "Follow"
    }
    
    func setup(fromUser user: User, withImage image: UIImage?) {
        setup(fromUser: user)
        self.userImageView.image = image
    }
    
    func toggleFollow() {
        if self.followLabel.text == "Follow" {
            self.followLabel.text = "Unfollow"
        } else {
            self.followLabel.text = "Follow"
        }
    }
}
