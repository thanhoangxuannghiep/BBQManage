//
//  monan_model.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/15/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

public class MonAn
{
    var id : Int?
    var tenma : String
    var motama : String
    var giatien : Int
    init (Id: Int, tenMA: String, motaMA: String, gia: Int )
    {
        self.id = Id
        self.tenma = tenMA
        self.motama = motaMA
        self.giatien = gia
    }
}
