//
//  SenderCell.swift
//  ChatIntigrate
//
//  Created by Sanskar IOS Dev on 27/03/25.
//

import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet weak var lblsendMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblsendMessage.textAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
