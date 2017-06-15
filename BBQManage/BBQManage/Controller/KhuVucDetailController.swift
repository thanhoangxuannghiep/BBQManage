//
//  KhuVucDetailController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class KhuVucDetailController: UIViewController {

    @IBOutlet weak var slideshowScrollView: UIScrollView!
    
    
    //Dữ liệu kết nối với webservice
    var urlPath = "https://bbqmanage.000webhostapp.com/kv/get/"
    
    //Các thông tin khu vực
    @IBOutlet weak var txtTenKhuVuc: UITextField!
    @IBOutlet weak var txtMoTaKhuVuc: UITextView!
    @IBOutlet weak var imgAnhKhuVuc: UIImageView!
    
    //Dữ liệu truyền qua khi chọn cell ở danh sách khu vực
    var idKV : Int!
    var tenKV : String!
    var motaKV : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thông tin khu vực" + String(idKV)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        //Set dữ liệu các thông tin khu vực
        //urlPath = urlPath + String(idKV)
        
        //ParseData(url: urlPath)
        txtTenKhuVuc.text = tenKV
        txtMoTaKhuVuc.text = motaKV
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func saveTapped()
    {
        
    }
}
