//
//  DSMonAnCell.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class DSMonAnCell: UITableViewCell {

    @IBOutlet weak var imgMonAn: UIImageView!
    @IBOutlet weak var txtTenMon: UILabel!
    @IBOutlet weak var txtGiaTien: UILabel!
    @IBOutlet weak var txtSoLuongInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}