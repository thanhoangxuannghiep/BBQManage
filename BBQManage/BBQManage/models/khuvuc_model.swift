//
//  khuvuc_model.swift
//  BBQManage
//
//  Created by Than Hoang Xuan Nghiep on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

public class KhuVuc{
    var id: Int?
    var tenkv : String
    var motaKV: String
    init (id : Int, tenkv: String, motaKV: String){
        self.id  = id
        self.tenkv = tenkv
        self.motaKV = motaKV
    }
}
