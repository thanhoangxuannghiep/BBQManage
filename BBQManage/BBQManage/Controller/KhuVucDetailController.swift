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
    
    var idKV : Int!
    //Dữ liệu kết nối với webservice
    
    var urlPath = "https://bbqmanage.000webhostapp.com/kv/get/"
    
    //Các thông tin khu vực
    @IBOutlet weak var txtTenKhuVuc: UITextField!
    @IBOutlet weak var txtMoTaKhuVuc: UITextView!
    @IBOutlet weak var imgAnhKhuVuc: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thông tin khu vực" + String(idKV)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        //Set dữ liệu các thông tin khu vực
        urlPath = urlPath + String(idKV)
        
        ParseData(url: urlPath)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hàm get dữ liệu từ webservice
    func ParseData(url:String){
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if(error != nil){
                print("error")
            }else{
                do{
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
                    /*for item in fetchData{
                        let eachKV = item as! [String : Any]
                        self.KV.id = eachKV["maKV"] as! Int
                        self.KV.tenkv = eachKV["TenKV"] as! String
                        self.KV.motaKV = eachKV["MoTaKV"] as! String
                        print(self.KV.tenkv)
                        print(self.KV.motaKV)
                    }*/
                    self.txtTenKhuVuc.text = fetchData.value(forKey: "TenKV") as! String
                    self.txtMoTaKhuVuc.text = fetchData.value(forKey: "MoTaKV") as! String
                    print(fetchData.allKeys)
                    print(fetchData.value(forKey: "TenKV")!)
                    
                }
                catch{
                    print("Error 2")
                }
            }
        }
        task.resume()
    }
    

    func saveTapped()
    {
        
    }
}
