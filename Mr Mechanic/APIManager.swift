//
//  APIManager.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 11/04/16.
//  Copyright © 2016 Ravi Ranjan. All rights reserved.
//

import Foundation
class APIManager{
    
    var mechanic:Mechanic?
    var mechanics = [Mechanic]()
    private let ERROR:NSArray = ["Error"]
    
    //MARK:-Get Methods
    
    func getDetails(HTTPMethod httpMethod:String,URL urlString:String,completion:(result:NSArray,response:Int)->Void){
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        request.HTTPMethod = httpMethod
        
        request.timeoutInterval = 600
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil{
                dispatch_async(dispatch_get_main_queue()){
                    if let httpResponse = response as? NSHTTPURLResponse{
                        let status = httpResponse.statusCode
                        completion(result:self.ERROR ,response:status)
                    }
                }
            }else{
                do{
                    if let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSArray{
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            dispatch_async(dispatch_get_main_queue()){
                                if let httpResponse = response as? NSHTTPURLResponse{
                                    
                                    //                                    for data in jsonData{
                                    //                                        
                                    //                                    }
                                    
                                    let status = httpResponse.statusCode
                                    completion(result: jsonData,response:status)
                                }
                            }
                        }
                    }
                }catch{
                    dispatch_async(dispatch_get_main_queue() ){
                        if let httpResponse = response as? NSHTTPURLResponse{
                            let status = httpResponse.statusCode
                            completion(result: self.ERROR,response:status)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}