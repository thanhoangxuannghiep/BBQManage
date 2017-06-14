//
//  banan_model.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

public class BanAn {
    var id: Int?
    var soba : String
    var motaba: String
    init (id : Int, soBA: String, motaBA: String){
        self.id  = id
        self.soba = soBA
        self.motaba = motaBA
    }
}
