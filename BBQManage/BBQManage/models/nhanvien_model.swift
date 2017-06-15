//
//  nhanvien_model.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/15/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

public class NhanVien
{
    var id: Int?
    var ten: String
    var email: String
    var pass: String
    var kv : Int?
    var quanly : Int?
    init(Id : Int, Ten : String, Email : String, Pass : String, Kv : Int, Qly : Int)
    {
        self.id = Id
        self.ten = Ten
        self.email = Email
        self.pass = Pass
        self.kv = Kv
        self.quanly = Qly
    }
}
