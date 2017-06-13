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
    
    //Dữ liệu giả
    let arr = ["Khu vực a", "Khu vực b", "Khu vực c"]
    var listdata = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Kết nối webservice
        let urlPath = "https://bbqmanage.000webhostapp.com/kv/all"
        request2(url1: urlPath)
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách khu vực"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        //Hiển thị dữ liệu table
        tableKhuVuc.delegate = self
        tableKhuVuc.dataSource = self
        
       
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
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "khuvuc_cell") as! KhuVucCell
        let item = self.listdata[0]
        cell.lblTenKhuVuc.text = item["TenKV"] as! String
        return cell
    }
    // Xử lý truyền dữ liệu khi click vào cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "khuvucDetail")
        {
            let controller = segue.destination as! KhuVucDetailController
            controller.idKV = self.tableKhuVuc.indexPathForSelectedRow?.row
        }
    }
    
    //Hàm gửi request và nhận dữ liệu từ webservice
    func request2 ( url1: String){
        print("testing")
        
        let Urlrq = URL(string: url1)
        let task = URLSession.shared.dataTask(with: Urlrq!, completionHandler: {
            (data, response, error) in
            if (error != nil){
                print(error.debugDescription)
                print(error?.localizedDescription)
            } else {
                do {
                    self.listdata = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                } catch let error as NSError{
                    print(error)
                }
            }
            
        })
        task.resume()
    }

}
