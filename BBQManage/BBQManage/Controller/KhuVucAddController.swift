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
    
    //khai bao bien chua du lieu hinh anh
    var base64String : String!
    var arrImageData = [String]()
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

    func addTapped()
    {
        //create directory
        let json: [String: Any] = ["tenKV": (txtTenKV.text)!, "motaKV": (motaKV.text)!]
        //parsing dict to json
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        // create post request
        let url = URL(string: "https://bbqmanage.000webhostapp.com/api/kv")!
        let request = NSMutableURLRequest(url: url)
        //set content-type to json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST" //method for add event
        
        // insert json data to the request
        request.httpBody = jsonData
        //send request and get result from api
        let task = URLSession.shared.dataTask(with: request as URLRequest ) { (data, response, error) in
            if let resp = response{
                print(resp)
                //view response of api
            }
            
            guard let data = data, error == nil else {
                //if insert error, print this error
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            
            //data is array of json
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let result = responseJSON as? [String : AnyObject]{
                //for item in self.arrImageData {
                    //print(self.arrImageData.count)
                    
                    let post = "maKV=\((result["id"])!)&imageURL=\((self.base64String))"
                    let urlPost = "https://bbqmanage.000webhostapp.com/api/kvi"
                    self.upImage(post: post, urlPost: urlPost)
                //}
            }
        }
        
        task.resume()
    }
    
    func upImage(post: String?, urlPost: String? ) {
        
        
        let url: URL = URL(string: urlPost!)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = post?.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if error != nil {
                print(error)
            }else {
                let contentRun = String(data: data!, encoding: String.Encoding.utf8)
                print(contentRun)
            }
        }
        task.resume()
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
            let imgData:NSData = UIImageJPEGRepresentation(pickedImage, 1.0)! as NSData
            self.base64String = imgData.base64EncodedString(options: .lineLength64Characters)
            //print(base64String)
            self.arrImageData.append(self.base64String)
            addImageTo(scrollView: slideshowScrollView, image: pickedImage)
        }
    }
}
