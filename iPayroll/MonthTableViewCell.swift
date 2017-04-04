//
//  MonthsTableViewCell.swift
//  iPayroll
//
//  Created by Joel Pineiro on 3/22/17.
//  Copyright © 2017 Joel Pineiro. All rights reserved.
//

import UIKit

class MonthTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
