//
//  DSBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/11/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class DSBanAnController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITabBarDelegate {
    
    @IBOutlet weak var DSBanan: UITableView!
    @IBOutlet weak var lblTenKhuVuc: UILabel!
    
    @IBOutlet weak var tabbarFilter: UITabBar!
    //Biến hiển thị left menu
    var left_menu : LeftMenuController!
    
    //Dữ liệu kết nối webservice bàn ăn
    let urlPath_QL = "http://bbqmanage.000webhostapp.com/api/ba" // url cho quản lý, hiển thị hết bàn ăn
    //url dành cho nhân viên
    var urlPath_NV = "http://bbqmanage.000webhostapp.com/api/bakv/"
    
    var arraybackup = arrayBA
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Kiểm tra user có phải quán lý hay không
        if(quanly)
        {
            //Nếu là quản lý thì dùng url của quán lý
            ParseData(url: urlPath_QL)
            lblTenKhuVuc.isHidden = true
        }
        else
        {
            //Truyền id khu vực nhân viên đó phụ trách vào url
            urlPath_NV = urlPath_NV + String(idKV)
            //Hiển thị bàn ở khu vực đó
            ParseData(url: urlPath_NV)
            lblTenKhuVuc.text = "Khu vực " + String(idKV)
        }

        // Do any additional setup after loading the view.
        self.DSBanan.delegate = self
        self.DSBanan.dataSource = self
        
        //Hiển thị left menu
        left_menu = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuController") as! LeftMenuController
        
        //Hiển thị search bar vào table
        searchbar()
        tabbarFilter.delegate = self
        tabbarFilter.selectedItem = itemTatCa
        DSBanan.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // SEARCH BAR
    //Thêm search bar vào table view
    func searchbar()
    {
        let searchbar = UISearchBar(frame : CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchbar.delegate = self
        //Cho phép tìm kiếm theo
        searchbar.tintColor = UIColor.lightGray
        self.DSBanan.tableHeaderView = searchbar
    }
    // Bắt sự kiện thay đổi text trong search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var url : String!
        if(quanly)
        {
            url = urlPath_QL
        }
        else
        {
            url = urlPath_NV
        }
        if searchText == ""
        {
            arrayBA = arraybackup
            if(tabbarFilter.selectedItem == itemDaDat)
            {
                arrayBA = arrayBA.filter({ (banan) -> Bool in
                    if(banan.status == 1)
                    {
                        return true
                    }
                    else {
                        return false
                    }
                })
            }
            if(tabbarFilter.selectedItem == itemTrong)
            {
                arrayBA = arrayBA.filter({ (banan) -> Bool in
                    if(banan.status == 0)
                    {
                        return true
                    }
                    else {
                        return false
                    }
                })
            }
        }
        else{
            arrayBA = arrayBA.filter({ (banan) -> Bool in
                return banan.soba.lowercased().contains(searchText.lowercased())
            })
        }
        DSBanan.reloadData()
    }
    // END SEARCH BAR
    
    //Hàm lấy dữ liệu danh sách bàn ăn
    /*func ParseData(url:String)
    {
        arrayBA = [BanAn]()
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
                            let eachBA = item
                            let id = eachBA["maBA"] as! Int
                            let soBA = eachBA["SoBanAn"] as! String
                            let motaBA = eachBA["MoTaBA"] as! String
                            arrayBA.append(BanAn(id: id, soBA: soBA, motaBA: motaBA))
                            self.DSBanan.reloadData()

                        }
                    }
//                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
//                    for item in fetchData{
//                        let eachBA = item as! [String : Any]
//                        let id = eachBA["maBA"] as! Int
//                        let soBA = eachBA["SoBanAn"] as! String
//                        let motaBA = eachBA["MoTaBA"] as! String
//                        arrayBA.append(BanAn(id: id, soBA: soBA, motaBA: motaBA))
//                        self.DSBanan.reloadData()
//                    }
                }
                catch{
                    print("Error 2")
                }
            }
        }
        task.resume()
    }*/
    
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
                    self.arraybackup = arrayBA
                    self.DSBanan.reloadData()
                    print(arrayBA.count)
                }
                catch{
                    print(response)
                }
            }
        }
        task.resume()
    }


    
    // Cài đặt cho Tableview danh sách bàn ăn
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBA.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BanAnCell") as! BanAnCell
        let item = arrayBA[indexPath.row]
        cell.TenBanAn.text = item.soba
        cell.idBA = item.id
        // hiển thị trạng thái bàn
        if(item.status == 0 )
        {
            cell.TrangThai.text = "Còn trống"
            cell.imgStatus.image = #imageLiteral(resourceName: "available.png")
        }
        else{
            cell.imgStatus.image = #imageLiteral(resourceName: "using.png")
            cell.TrangThai.text = "Có khách"
        }
        return cell
    }
    //End table view
    
    // Left menu show
    @IBAction func Click_ShowLeftMenu(_ sender: UIBarButtonItem) {
        if menu_bool
        {
            show_menu()
        }
        else{
            close_menu()
        }
    }
    
    func show_menu()
    {
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.addChildViewController(self.left_menu)
            self.view.addSubview(self.left_menu.view)
            menu_bool = false
        }
        
    }
    
    func close_menu()
    {
        self.left_menu.view.removeFromSuperview()
        menu_bool = true
    }
    //End left menu
    
    @IBOutlet weak var itemTatCa: UITabBarItem!
    @IBOutlet weak var itemTrong: UITabBarItem!
    @IBOutlet weak var itemDaDat: UITabBarItem!
    //TAB BAR
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//        if(tabBarIndex == 1)
//        {
//            arrayBA = arrayBA.filter({ (banan) -> Bool in
//                if ( banan.status == 0)
//                {
//                    return true
//                }
//                else{
//                    return false
//                }
//            })
//        }
//        DSBanan.reloadData()
//    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        var url : String!
        if(quanly)
        {
            url = urlPath_QL
        }
        else
        {
            url = urlPath_NV
        }
        
        if item == itemTrong
        {
            arrayBA = arraybackup
            arrayBA = arrayBA.filter({ (banan) -> Bool in
                if(banan.status == 0)
                {
                    return true
                }
                else {
                    return false
                }
            })
        }
        if item == itemDaDat
        {
            arrayBA = arraybackup
            arrayBA = arrayBA.filter({ (banan) -> Bool in
                if(banan.status == 1)
                {
                    return true
                }
                else {
                    return false
                }
            })
        }
        if item == itemTatCa
        {
            ParseData(url: url)
        }
        DSBanan.reloadData()
    }
    

}
