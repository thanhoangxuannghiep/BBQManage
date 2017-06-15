//
//  MonAnDetailController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class MonAnDetailController: UIViewController {

    @IBOutlet weak var txtTenMon: UITextField!
    @IBOutlet weak var txtMoTa: UITextView!
    @IBOutlet weak var txtGiaTien: UITextField!
    @IBOutlet weak var imgHinhAnh: UIImageView!
    
    @IBOutlet weak var slideshowScrollView: UIScrollView!
    
    //Dữ liệu truyền từ danh sách món ăn qua
    var idMA : Int!
    var tenMA : String!
    var giaMA : Int!
    var motaMA : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Thông tin khu vực" + String(idMA)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        txtTenMon.text = tenMA
        txtMoTa.text = motaMA
        txtGiaTien.text = String(giaMA)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveTapped()
    {
        
    }

    
}
