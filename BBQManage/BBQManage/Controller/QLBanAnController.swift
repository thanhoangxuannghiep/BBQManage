//
//  QLBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class QLBanAnController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var QLBanAnTable: UITableView!
    
    //url kết nối tới webservice
    let urlPath_QL = "http://bbqmanage.000webhostapp.com/ba/all"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Danh sách bàn ăn"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        QLBanAnTable.delegate = self
        QLBanAnTable.dataSource = self
        
        ParseData(url: urlPath_QL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped()
    {
        performSegue(withIdentifier: "addBanAn", sender: self)
    }
    
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
                        arrayBA.append(BanAn(id: id, soBA: soBA, motaBA: motaBA))
                        
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
        //cell.TenBanAn.text = item.soba
        //cell.idBA = item.id
        return cell
    }

}
