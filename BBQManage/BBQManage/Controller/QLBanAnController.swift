//
//  QLBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLBanAnController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var QLBanAnTable: UITableView!
    
    //url kết nối tới webservice
    let urlPath_QL = "http://bbqmanage.000webhostapp.com/api/ba"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách bàn ăn"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        QLBanAnTable.delegate = self
        QLBanAnTable.dataSource = self
        
        //Hiển thị danh sách bàn ăn từ webservice
        ParseData(url: urlPath_QL)
        
        //Lấy danh sách khu vực
        DsKhuVuc()
        print(array)
        //Cho phép edit trong table view
        QLBanAnTable.allowsMultipleSelectionDuringEditing = true
        //Thêm search bar vào table
        searchbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped()
    {
        performSegue(withIdentifier: "addBanAn", sender: self)
    }
    
    // Lấy danh sách bàn ăn
    func ParseData(url:String){
        arrayBA = [BanAn]()
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
                        let eachBA = item.value
                        let id = eachBA["maBA"] as! Int
                        let soBA = eachBA["SoBanAn"] as! String
                        let motaBA = eachBA["MoTaBA"] as! String
                        let KV = eachBA["idKV"] as! Int
                        let stt = eachBA["Status"] as! Int
                        arrayBA.append(BanAn(id: id, soBA: soBA, motaBA: motaBA, KV: KV, Status: stt))
                        
                    }
                    self.QLBanAnTable.reloadData()
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }
    
    //Lấy danh sách khu vực
    func DsKhuVuc()
    {
        array = [KhuVuc]()
        var request = URLRequest(url: URL(string: "http://bbqmanage.000webhostapp.com/api/kv")!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let res = response {
                print(res)
            }
            
            if(error != nil){
                print("error")
            }
            else
            {
                do
                {
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String: AnyObject]
                    for item in fetchData
                    {
                        let eachKV = item.value
                        let id = eachKV["maKV"] as! Int
                        let tenKV = eachKV["TenKV"] as! String
                        let motaKV = eachKV["MoTaKV"] as! String
                        array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
                        
                    }
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }
    
    //TABLE VIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBA.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qlbanan_cell") as! QLBanAnCell
        let ba = arrayBA[indexPath.row]
        cell.txtTenBan.text = ba.soba
        cell.idBan = ba.id
        cell.idKV = ba.idKV
        for kv in array
        {
            if( kv.id == cell.idKV )
            {
                cell.txtKhuVuc.text = kv.tenkv
            }
        }
        return cell
    }
    //Cho phép edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Lấy giá trị id từ cell được chọn
        let cell = self.QLBanAnTable.cellForRow(at: indexPath) as! QLBanAnCell
        // Tạo url để xoá
        let urlba = "http://bbqmanage.000webhostapp.com/api/ba/" + String(cell.idBan)
        let url = URL(string: urlba)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        let data = "_method=DELETE" //PUT
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
            
            let contenRun = String(data: data, encoding: String.Encoding.utf8)
            //            if( contenRun == "{\"msg\":\"Success\"}") {
            //                _ = self.navigationController?.popViewController(animated: true)
            //            }
            print(contenRun)
        }
        
        task.resume()
        
    }
    //END TABLE VIEW
    
    // SEARCH BAR
    //Thêm search bar vào table view
    func searchbar()
    {
        let searchbar = UISearchBar(frame : CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchbar.delegate = self
        searchbar.tintColor = UIColor.lightGray
        self.QLBanAnTable.tableHeaderView = searchbar
    }
    // Bắt sự kiện thay đổi text trong search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""
        {
            ParseData(url: urlPath_QL)
        }
        else{
            arrayBA = arrayBA.filter({ (banan) -> Bool in
                return banan.soba.lowercased().contains(searchText.lowercased())
            })
        }
        QLBanAnTable.reloadData()
    }
    // END SEARCH BAR

}
