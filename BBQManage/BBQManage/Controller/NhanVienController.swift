//
//  NhanVienController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class NhanVienController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //URL kết nối webservice lấy danh sách nhân viên
    let urlPath_NV = "http://bbqmanage.000webhostapp.com/nv/all"
    
    @IBOutlet weak var tableNhanVien: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách nhân viên"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableNhanVien.delegate = self
        tableNhanVien.dataSource = self
        
        ParseData(url: urlPath_NV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped()
    {
        performSegue(withIdentifier: "addNhanVien", sender: self)
    }
    
    //Truyền dữ liệu qua form NhanVienDetail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "nhanvienDetail")
        {
            //Lấy đúng cell được chọn
            let index = self.tableNhanVien.indexPathForSelectedRow
            let cell = self.tableNhanVien.cellForRow(at: index!) as! NhanVienCell
            
            //truyền qua view NhanVienDetail
            let controller = segue.destination as! NhanVienDetailController
            controller.idNV = cell.idNV
            controller.tenNV = cell.txtTenNhanVien.text!
            controller.emailNV = cell.emailNV
            controller.passNV = cell.passNV
            controller.kvNV = cell.kvNV
        }
    }
    
    
    // Lấy danh sách nhân viên từ webservice
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
                    for item in fetchData
                    {
                        let eachNV = item.value
                        let id = eachNV["id"] as! Int
                        let tenNV = eachNV["name"] as! String
                        let mailNV = eachNV["email"] as! String
                        let passNV = eachNV["password"] as! String
                        let khuvucNV = eachNV["idKV"] as! Int
                        let quanly = eachNV["NVQL"] as! Int
                        arrayNV.append(NhanVien(Id: id, Ten: tenNV, Email: mailNV, Pass: passNV, Kv: khuvucNV, Qly: quanly))
                    }
                    self.tableNhanVien.reloadData()
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }
    
    // Hàm cho table view  danh sách nhân viên
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNV.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nhanvien_cell") as! NhanVienCell
        let nv = arrayNV[indexPath.row]
        cell.idNV = nv.id
        cell.txtTenNhanVien.text = nv.ten
        cell.emailNV = nv.email
        cell.passNV = nv.pass
        cell.kvNV = nv.kv
        return cell
    }

}
