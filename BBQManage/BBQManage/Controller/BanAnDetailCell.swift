//
//  BanAnDetailCell.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/15/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class BanAnDetailCell: UITableViewCell {

    @IBOutlet weak var txtTenMon: UILabel!
    @IBOutlet weak var txtSoLuong: UILabel!
    @IBOutlet weak var txtThanhTIen: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
