//
//  ParseDataFromAPI.swift
//  BBQManage
//
//  Created by Than Hoang Xuan Nghiep on 6/14/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

extension UIViewController {

//    func ParseData(url:String){
//        array = [KhuVuc]()
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
//        
//        let task = session.dataTask(with: request) { (data, response, error) in
//            
//            if(error != nil){
//                print("error")
//            }else{
//                do{
//                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
//                    for item in fetchData{
//                        let eachKV = item as! [String : Any]
//                        let id = eachKV["maKV"] as! Int
//                        let tenKV = eachKV["TenKV"] as! String
//                        let motaKV = eachKV["MoTaKV"] as! String
//                        array.append(KhuVuc(id: id, tenkv: tenKV, motaKV: motaKV))
//                        
//                    
//                    }
//                }
//                catch{
//                    print("Error 2")
//                }
//            }
//        }
//        task.resume()
//    }

}
