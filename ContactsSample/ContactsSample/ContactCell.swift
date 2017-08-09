//
//  ContactCell.swift
//  ContactsSample
//
//  Created by Prasad.d on 03/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var buttonCheckUncheck: UIButton!
    @IBOutlet weak var labelContactName: UILabel!
    @IBOutlet weak var buttonDisclosure: UIButton!
    
    @IBOutlet weak var labelContactNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none

        // Configure the view for the selected state
    }

}
