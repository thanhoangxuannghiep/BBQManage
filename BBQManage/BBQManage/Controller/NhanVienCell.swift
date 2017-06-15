//
//  NhanVienCell.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class NhanVienCell: UITableViewCell {

    @IBOutlet weak var txtTenNhanVien: UILabel!
    @IBOutlet weak var imgNhanVien: UIImageView!
    
    var idNV : Int!
    var emailNV : String!
    var passNV : String!
    var kvNV : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
