//
//  KhuVucDetailController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class KhuVucDetailController: UIViewController {

    var idKV : Int?
    
    //Các thông tin khu vực
    @IBOutlet weak var txtTenKhuVuc: UITextField!
    @IBOutlet weak var txtMoTaKhuVuc: UITextView!
    @IBOutlet weak var imgAnhKhuVuc: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thông tin khu vực"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        //Set dữ liệu các thông tin khu vực
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func saveTapped()
    {
        
    }
}
