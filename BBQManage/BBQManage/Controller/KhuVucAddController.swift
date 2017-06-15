//
//  KhuVucAddController.swift
//  BBQManage
//
//  Created by Thanh Tung on 6/13/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class KhuVucAddController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var motaKV: UITextView!
    @IBOutlet weak var txtTenKV: UITextField!
    
    @IBOutlet weak var slideshowScrollView: UIScrollView!
    
    //DS hình ảnh dc chọn
    var selectedImagesQueue = [UIImage]()
    //Tạo đối tượng image picker
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Thêm khu vực"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTapped()
    {
        let json:  [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
        
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        let data = "tenKV="+(txtTenKV.text)!+"&motaKV="+(motaKV.text)!
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
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
            let contenRun = String(data: data, encoding: String.Encoding.utf8)
            if( contenRun == "Success") {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        task.resume()
        
//        let json:  [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
//        
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        // create post request
//        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        // insert json data to the request
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            if let response = response {
//                print(response)
//            }
//            if let data = try? JSONSerialization.jsonObject(with: data){
//                print(data)
//            }
////            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
////            if let responseJSON = responseJSON as? [String: Any] {
////                print(1)
////                print(responseJSON)
////            }
//        }
//        
//        task.resume()
        
//        let json: [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        
//        // create post request
//        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")!
//        var request = NSMutableURLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpMethod = "POST"
//        
//        // insert json data to the request
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest ) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            
//            if let resp = response{
//                print(resp)
//            }
//            
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
//        }
//        
//        task.resume()
    }
    
    @IBAction func Click_ChonAnh(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }
    
    //imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            selectedImagesQueue += [pickedImage] // Đưa vào hàng đợi để lưu
            addImageTo(scrollView: slideshowScrollView, image: pickedImage)
        }
    }
    // Lúc tạo ra scrollView height 120
    func addImageTo(scrollView: UIScrollView, image: UIImage) {
        let width = CGFloat(100)
        let height = CGFloat(100)
        let spacing = CGFloat(10)
        
        let size = scrollView.contentSize // Kích thước hiện tại
        var count = CGFloat(0)
        
        if (size.width > 0) { // Đang  chứa bao nhiêu hình?
            count = (size.width - spacing ) / (width + spacing)
        }
        
        // Tạo mới một imageview
        let img = UIImageView(frame: CGRect(x: spacing + (width + spacing) * count, y:10, width: width, height: height))
        img.image = image
        scrollView.addSubview(img) // Thêm ảnh mới vào scrollview
        
        // Cập nhật lại kích thước của content size để chứa hình mới
        count += 1
        scrollView.contentSize = CGSize(width: spacing + (width + spacing) * CGFloat(count), height: height)
        
    }
}
