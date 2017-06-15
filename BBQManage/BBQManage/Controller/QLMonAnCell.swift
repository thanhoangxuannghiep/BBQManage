//
//  QLMonAnCell.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLMonAnCell: UITableViewCell {

    @IBOutlet weak var imgMonAn: UIImageView!
    @IBOutlet weak var txtTenMonAn: UILabel!
    @IBOutlet weak var txtGiaTien: UILabel!
    
    var idMA : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
