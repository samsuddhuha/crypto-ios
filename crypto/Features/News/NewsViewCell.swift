//
//  NewsViewCell.swift
//  crypto
//
//  Created by Samsud Dhuha on 28/07/21.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var labelJournalist:UILabel!
    @IBOutlet weak var labelTitle:UILabel!
    @IBOutlet weak var labelBody:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
