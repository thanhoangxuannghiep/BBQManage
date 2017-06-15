//
//  NhanVienDetailController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class NhanVienDetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var txtTenNhanVien: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgHinhAnh: UIImageView!
    @IBOutlet weak var pickerKhuVuc: UIPickerView!
    
    //Dữ liệu nhận vào
    var idNV : Int!
    var tenNV : String!
    var emailNV : String!
    var passNV : String!
    var kvNV : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thông tin "
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        //Hiển thị  dữ liệu được truyền qua từ cell
        txtTenNhanVien.text = tenNV
        txtEmail.text = emailNV
        txtPassword.text = passNV
        
        //Lấy dữ liệu danh sách khu vực từ web service
        ParseData(url: "http://bbqmanage.000webhostapp.com/api/kv")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveTapped()
    {
        
    }
    
    //Lấy dữ liệu khu vực về và đưa vào pickerview
    func ParseData(url:String){
        array = [KhuVuc]()
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
                    //                    if let data = data {
                    //                        let myJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers ) as! [String: AnyObject]
                    //
                    //                        for item in myJson {
                    //                            let eachKV = item.value
                    //                            let id = eachKV["maKV"] as! Int
                    //                            let tenKV = eachKV["TenKV"] as! String
                    //                            let motaKV = eachKV["MoTaKV"] as! String
                    //                            array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
                    //                            self.tableKhuVuc.reloadData()
                    //                        }
                    //                    }
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String: AnyObject]
                    for item in fetchData
                    {
                        let eachKV = item.value
                        let id = eachKV["maKV"] as! Int
                        let tenKV = eachKV["TenKV"] as! String
                        let motaKV = eachKV["MoTaKV"] as! String
                        array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
                    }
                    self.pickerKhuVuc.delegate = self
                    self.pickerKhuVuc.dataSource = self
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }
    
    //function for UIPicker
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return array[row].tenkv
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
