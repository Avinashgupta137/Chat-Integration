//
//  ReceiverCell.swift
//  ChatIntigrate
//
//  Created by Sanskar IOS Dev on 27/03/25.
//

import UIKit

class ReceiverCell: UITableViewCell {

    @IBOutlet weak var lblReciveMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblReciveMessage.textAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
