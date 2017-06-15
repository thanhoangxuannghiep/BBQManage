//
//  QLMonAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLMonAnController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableMonAn: UITableView!
    
    //URL kết nối webservice món ăn
    let urlPath_MA = "http://bbqmanage.000webhostapp.com/ma/all"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách món"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableMonAn.delegate = self
        tableMonAn.dataSource = self
        
        ParseData(url: urlPath_MA)
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

}
