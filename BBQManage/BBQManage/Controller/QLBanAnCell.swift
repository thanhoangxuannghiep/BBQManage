//
//  QLBanAnCell.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLBanAnCell: UITableViewCell {
    
    //Thông tin hiển thị của bàn ăn
    @IBOutlet weak var imgBanAn: UIImageView!
    @IBOutlet weak var txtKhuVuc: UILabel!
    @IBOutlet weak var txtTenBan: UILabel!
    
    //Biến lưu id của bàn ( nếu có dùng )
    var idBan : Int!
    var idKV : Int!
    var motaBA : String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
