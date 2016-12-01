//
//  DetailTableViewCell.swift
//  Epower1
//
//  Created by Bharath Bandaru on 26/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myview.clipsToBounds=true
        myview.layer.cornerRadius=10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
