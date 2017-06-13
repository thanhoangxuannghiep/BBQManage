//
//  DangNhapController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/11/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class DangNhapController: UIViewController {

    @IBOutlet weak var input_username: UITextField!
    @IBOutlet weak var input_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true;
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.navigationController?.isNavigationBarHidden = false;
    }

    @IBAction func Click_DangNhap(_ sender: UIButton) {
        //Xét xem có nhập dữ liệu chưa
        if(input_username.text == "" || input_password.text == "" )
        {
            create_alert(title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin !")
        }
        else {
            //Xử lí đăng nhập
            performSegue(withIdentifier: "openMain", sender: self)
            //Các xử lí tiếp theo sau khi đăng nhập thành công
        }
    }
    
    //Hàm  hiển thị alert message
    func create_alert(title : String, message : String )
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {  (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
