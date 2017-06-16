//
//  QLMonAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLMonAnController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableMonAn: UITableView!
    
    //URL kết nối webservice món ăn
    let urlPath_MA = "http://bbqmanage.000webhostapp.com/api/ma"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách món"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableMonAn.delegate = self
        tableMonAn.dataSource = self
        
        //Hiển thị danh sách món ăn
        ParseData(url: urlPath_MA)
        
        //Cho phép edit trong table món ăn
        tableMonAn.allowsMultipleSelectionDuringEditing = true
        //Thêm searchbar vào table món ăn
        searchbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Truyền dữ liệu qua form MonAnDetail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "monanDetail")
        {
            //Lấy id món ăn từ cell
            let index = self.tableMonAn.indexPathForSelectedRow
            let cell = self.tableMonAn.cellForRow(at: index!) as! QLMonAnCell
            let id = cell.idMA
            //let ten = cell.txtTenMonAn.text
            //truyền qua view MonAnDetail
            let controller = segue.destination as! MonAnDetailController
            controller.idMA = id
            controller.tenMA = cell.txtTenMonAn.text!
            controller.motaMA = cell.motaMA
            controller.giaMA = Int(cell.txtGiaTien.text!)
        }
    }

    func addTapped()
    {
        performSegue(withIdentifier: "addMonAn", sender: self)
    }
    
    //Hàm gọi ra danh sách món ăn
    func ParseData(url:String){
        arrayMA = [MonAn]()
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
                        let eachMA = item.value
                        let id = eachMA["maMonAn"] as! Int
                        let tenMA = eachMA["TenMonAn"] as! String
                        let motaMA = eachMA["MoTaMA"] as! String
                        let gia = eachMA["Gia"] as! Int
                        //arrayBA.append(BanAn(id: id, soBA: soBA, motaBA: motaBA))
                        arrayMA.append(MonAn(Id: id, tenMA: tenMA, motaMA: motaMA, gia: gia))
                    }
                    self.tableMonAn.reloadData()
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }
    
    // TABLE VIEW
    // Hàm cho table view  quản lý danh sách món ăn
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMA.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qlmonan_cell") as! QLMonAnCell
        let ma = arrayMA[indexPath.row]
        cell.idMA = ma.id
        cell.txtTenMonAn.text = ma.tenma
        cell.txtGiaTien.text = String(ma.giatien)
        cell.motaMA = ma.motama
        return cell
    }
    // Cho phép edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Xử lí khi ấn nút delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Lấy giá trị id của cell
        let cell = self.tableMonAn.cellForRow(at: indexPath) as! QLMonAnCell
        //Thêm giá trị vào url
        var urlma = "http://bbqmanage.000webhostapp.com/api/ma/" + String(cell.idMA)
        //print(urlma)
        let url = URL(string: urlma)!
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
            //            if( contenRun == "Success") {
            //                _ = self.navigationController?.popViewController(animated: true)
            //            }
            print(contenRun)
        }
        
        task.resume()
    }
    // END TABLE VIEW
    
    //SEARCH BAR
    func searchbar()
    {
        let searchbar = UISearchBar(frame : CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchbar.delegate = self
        searchbar.tintColor = UIColor.lightGray
        self.tableMonAn.tableHeaderView = searchbar
    }
    // Bắt sự kiện thay đổi text trong search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""
        {
            ParseData(url: urlPath_MA)
        }
        else{
            
            arrayMA = arrayMA.filter({ (monan) -> Bool in
                return monan.tenma.lowercased().contains(searchText.lowercased())
            })
        }
        tableMonAn.reloadData()
    }
    // END SEARCH BAR

}
