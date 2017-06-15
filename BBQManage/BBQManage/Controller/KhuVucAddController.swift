//
//  KhuVucAddController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class KhuVucAddController: UIViewController {

    @IBOutlet weak var motaKV: UITextView!
    @IBOutlet weak var txtTenKV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Thêm khu vực"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTapped()
    {
        let json:  [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
        
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        let data = "tenKV="+(txtTenKV.text)!+"&motaKV="+(motaKV.text)!
        // insert json data to the request
    
        request.httpBody = data.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let res = response {
                print(res)
            }
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
            let contenRun = String(data: data, encoding: String.Encoding.utf8)
            if( contenRun == "Success") {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        task.resume()
        
//        let json:  [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
//        
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        // create post request
//        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        // insert json data to the request
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            if let response = response {
//                print(response)
//            }
//            if let data = try? JSONSerialization.jsonObject(with: data){
//                print(data)
//            }
////            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
////            if let responseJSON = responseJSON as? [String: Any] {
////                print(1)
////                print(responseJSON)
////            }
//        }
//        
//        task.resume()
        
//        let json: [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        
//        // create post request
//        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")!
//        var request = NSMutableURLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpMethod = "POST"
//        
//        // insert json data to the request
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest ) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            
//            if let resp = response{
//                print(resp)
//            }
//            
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
//        }
//        
//        task.resume()
    }
}
