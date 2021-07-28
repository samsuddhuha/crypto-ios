//
//  CryptoViewCell.swift
//  crypto
//
//  Created by Samsud Dhuha on 27/07/21.
//

import UIKit

class CryptoViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelFullName:UILabel!
    @IBOutlet weak var labelPrice:UILabel!
    @IBOutlet weak var labelChangePtc:UILabel!
    @IBOutlet weak var viewCryptoCell: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
