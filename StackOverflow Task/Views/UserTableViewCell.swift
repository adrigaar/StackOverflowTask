//
//  UserTableViewCell.swift
//  StackOverflow Task
//
//  Created by Thomas on 24/03/2025.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followSwitch: UISwitch!
    
    func setup(fromUser user: User) {
        self.nameLabel.text = user.name
        self.repLabel.text = String(user.rep)
        self.followSwitch.isOn = false // This to handle following later
    }
    
    func setup(fromUser user: User, withImage image: UIImage?) {
        setup(fromUser: user)
        self.userImageView.image = image
    }
}
