//
//  KhuVucController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class KhuVucController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableKhuVuc: UITableView!
    
    
    //Dữ liệu kết nối với webservice
    var  fetchKV = [KhuVuc]()
    let urlPath = "http://bbqmanage.000webhostapp.com/kv/all"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Kết nối webservice lấy dữ liệu về
        ParseData(url: urlPath)
        print(array.count)
        
        //Set navigation
        self.navigationItem.title = "Danh sách khu vực"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        //Hiển thị dữ liệu table
        tableKhuVuc.delegate = self
        tableKhuVuc.dataSource = self
    }
    
    //Hàm get dữ liệu từ webservice
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
                    if let data = data {
                        let myJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers ) as! [[String: AnyObject]]
                        for item in myJson {
                            let eachKV = item
                            let id = eachKV["maKV"] as! Int
                            let tenKV = eachKV["TenKV"] as! String
                            let motaKV = eachKV["MoTaKV"] as! String
                            array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
                            self.tableKhuVuc.reloadData()
                        }
                    }
//                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
//                    for item in fetchData{
//                        let eachKV = item as! [String : Any]
//                        let id = eachKV["maKV"] as! Int
//                        let tenKV = eachKV["TenKV"] as! String
//                        let motaKV = eachKV["MoTaKV"] as! String
//                        array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
//                        
//                        self.tableKhuVuc.reloadData()
//                    }
                }
                catch{
                    print("Error 2")
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Thực hiện thêm khu vực khi ấn vào nút thêm
    func addTapped()
    {
        performSegue(withIdentifier: "addKhuVuc", sender: self)
    }
    
    //Tableview khu vực
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return listdata.count
        //return arr.count
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "khuvuc_cell") as! KhuVucCell
        let item = array[indexPath.row]
        cell.lblTenKhuVuc.text = item.tenkv
        //cell.lblTenKhuVuc.text = String(cstring: item.id)
        cell.idKV = item.id
        return cell
    }
    
    // Xử lý truyền dữ liệu khi click vào cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "khuvucDetail")
        {
            //Lấy id khu vực từ cell
            let index = self.tableKhuVuc.indexPathForSelectedRow
            let cell = self.tableKhuVuc.cellForRow(at: index!) as! KhuVucCell
            let id = cell.idKV
            //truyền qua view KhuVucDetail
            let controller = segue.destination as! KhuVucDetailController
            controller.idKV = id
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
