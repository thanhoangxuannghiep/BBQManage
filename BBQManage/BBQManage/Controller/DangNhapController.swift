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
        //fetchKV = []
        super.viewDidLoad()
        //ParseData(url: urlPath)
        //print(array.count)
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
        //Nếu đã có dữ liệu nhập vào
        else {
            //Xử lí đăng nhập
            //performSegue(withIdentifier: "openMain", sender: self)
            //Các xử lí tiếp theo sau khi đăng nhập thành công
            //Gọi hàm tìm kiếm nhân viên theo username nhập vào
            let url_searchNV = "https://bbqmanage.000webhostapp.com/api/nv/" + input_username.text!
            //print(url_searchNV)
            ParseData(url: url_searchNV)
            //print(arrayNV.count)
        }
    }
    
    
    //Hàm hiển thị alert message
    func create_alert(title : String, message : String )
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {  (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //XỬ LÝ SEARCH NHÂN VIÊN THEO USER NAME
    //Lấy thông tin nhân viên theo username nhập vào trên webservice
    func ParseData(url:String){
        arrayNV = [NhanVien]()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let res = response {
                print(res)
            }
            
            if(error != nil){
                print("error")
            }else{
                do
                {
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String: AnyObject]
                    // Nếu tìm ko ra
                    if(fetchData.count == 0 )
                    {
                        //Thông báo cho người dùng
                        self.create_alert(title: "Lỗi", message: "Tài khoản không tồn tại !")
                    }
                    // TÌm ra tài khoản
                    else
                    {
                        let tk = fetchData
                        //Lấy pass word từ tài khoản trả về
                        let password = tk["password"] as! String
                        
                        // So sánh với password nhập vào
                        // Nếu không khớp
                        if(self.input_password.text != password )
                        {
                            self.create_alert(title: "Lỗi", message: "Sai mật khẩu !")
                        }
                        // Nếu khớp thì chuyển sang màn hình chính
                        else
                        {
                            user_name = tk["name"] as! String
                            let ql = tk["NVQL"] as! Int
                            //Kiểm tra phải quản lý hay không
                            if(ql == 1)
                            {
                                quanly = true
                            }
                            else
                            {
                                quanly = false
                            }
                            id_login = tk["id"] as! Int
                            idKV = tk["idKV"] as! Int
                            self.performSegue(withIdentifier: "openMain", sender: self)
                        }
                    }
                    
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }
    
    //END XỬ LÝ
    
    
}
