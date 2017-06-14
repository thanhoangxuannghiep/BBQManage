//
//  ThemBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class ThemBanAnController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var txtSoBan: UITextField!
    @IBOutlet weak var txtMoTa: UITextView!
    @IBOutlet weak var imgBanAn: UIImageView!
    @IBOutlet weak var pickerKhuVuc: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Thêm bàn"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
        
        ParseData(url: "https://bbqmanage.000webhostapp.com/kv/all")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTapped()
    {
        
    }
    
    //Hàm lấy về danh sách khu vực
    func ParseData(url:String){
        array = [KhuVuc]()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if(error != nil){
                print("error")
            }else{
                do{
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    for item in fetchData
                    {
                        let eachKV = item as! [String : Any]
                        let id = eachKV["maKV"] as! Int
                        let tenKV = eachKV["TenKV"] as! String
                        let motaKV = eachKV["MoTaKV"] as! String
                        array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
                        
                    }
                    self.pickerKhuVuc.delegate = self
                    self.pickerKhuVuc.dataSource = self
                }
                catch{
                    print("Error 2")
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
