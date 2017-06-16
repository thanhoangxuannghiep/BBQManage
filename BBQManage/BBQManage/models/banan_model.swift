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
    var idKV : Int?
    var status : Int?
    init (id : Int, soBA: String, motaBA: String, KV: Int, Status: Int){
        self.id  = id
        self.soba = soBA
        self.motaba = motaBA
        self.idKV = KV
        self.status = Status
    }
}
