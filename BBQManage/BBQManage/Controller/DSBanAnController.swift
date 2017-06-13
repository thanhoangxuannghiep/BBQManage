//
//  DSBanAnController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/11/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class DSBanAnController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var DSBanan: UITableView!
    
    //data test thử => có thể xoá
    let pickerData = ["Lớp 1", "Lớp 2", "Lớp 3"]
    
    //Biến hiển thị left menu
    var left_menu : LeftMenuController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.DSBanan.delegate = self
        self.DSBanan.dataSource = self
        
        //Hiển thị left menu
        left_menu = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuController") as! LeftMenuController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Cài đặt cho Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BanAnCell") as! BanAnCell
        cell.TenBanAn.text = pickerData[indexPath.row]
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

}
