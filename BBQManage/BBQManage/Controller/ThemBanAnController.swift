//
//  ThemBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class ThemBanAnController: UIViewController {

    @IBOutlet weak var txtSoBan: UITextField!
    @IBOutlet weak var txtMoTa: UITextView!
    @IBOutlet weak var imgBanAn: UIImageView!
    @IBOutlet weak var pickerKhuVuc: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thêm bàn"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTapped()
    {
        
    }
}
