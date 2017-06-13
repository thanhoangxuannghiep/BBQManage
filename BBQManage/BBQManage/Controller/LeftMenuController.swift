//
//  LeftMenuController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class LeftMenuController: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    //Nhóm chức năng chỉ dành cho quản lý
    @IBOutlet weak var btnQLKhuVuc: UIButton!
    @IBOutlet weak var btnQLBanAn: UIButton!
    @IBOutlet weak var btnQLMonAn: UIButton!
    @IBOutlet weak var btnQLNhanVien: UIButton!
    @IBOutlet weak var btnBaoCao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Hiển thị thông tin user
        lblUsername.text = user_name
        
        //Disable những nút quản lý nếu user đăng nhập không phải quán lý
        if(!quanly)
        {
            btnQLKhuVuc.isHidden = true
            btnQLBanAn.isHidden = true
            btnQLMonAn.isHidden = true
            btnQLNhanVien.isHidden = true
            btnBaoCao.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
