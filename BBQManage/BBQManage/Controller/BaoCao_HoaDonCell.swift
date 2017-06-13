//
//  BaoCao_HoaDonCell.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class BaoCao_HoaDonCell: UITableViewCell {

    @IBOutlet weak var hoadon_ngay: UILabel!
    @IBOutlet weak var hoadon_ban: UILabel!
    @IBOutlet weak var hoadon_giatri: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
