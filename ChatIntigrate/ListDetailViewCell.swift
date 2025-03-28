//
//  ListDetailViewCell.swift
//  ChatIntigrate
//
//  Created by Sanskar IOS Dev on 27/03/25.
//

import UIKit

class ListDetailViewCell: UITableViewCell {
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var imgListImages: UIImageView!
    @IBOutlet weak var lblNames: UILabel!
    @IBOutlet weak var lblMails: UILabel!
    @IBOutlet weak var lblNumbars: UILabel!
    @IBOutlet weak var lblCodes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func config(with booking: Datas) {
        lblDates.text = booking.updated_at
        lblNames.text = booking.customer?.name
        lblMails.text = booking.customer?.email
        lblNumbars.text = booking.customer?.mobile
        lblCodes.text = booking.postal_code
       
        let imageUrlString = "https://mt.localserverpro.com/public/storage/\(booking.image ?? "bookings/Zr1BSX3j58jMDMJ4ICPMkVzF1ki6YopE5HPlEdHq.png")"
        if let url = URL(string: imageUrlString) {
            imgListImages.loadImage(from: url)
        }        }
}
extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
