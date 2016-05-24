//
//  MyNSURLSessionRequest.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 3/16/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import Foundation
protocol MyNSURLSessionRequestDelegate: class{
    func sessionRequestDidComplete(request: MyNSURLSessionRequest)
    func sessionRequestFailed(request: MyNSURLSessionRequest, error: NSError)
}

class MyNSURLSessionRequest: NSObject{
    weak var delegate: MyNSURLSessionRequestDelegate?
    var urlRequest: NSURLRequest
    var expectedStatus: Int
    var successBlock: ((NSData?) -> Void)
    var failureBlock: ((NSError?) -> Void)
    
    // private properties
    var session: NSURLSession
    var task: NSURLSessionDataTask?
    var requestIdentifier: String
    
    init(request: NSURLRequest, session: NSURLSession, expStatus: Int, success: ((NSData?)-> Void),failure: ((NSError?) -> Void), delegate: MyNSURLSessionRequestDelegate){
        self.urlRequest = request
        self.expectedStatus = expStatus
        self.successBlock = success
        self.failureBlock = failure
        self.session = session
        self.delegate = delegate
        self.requestIdentifier = NSUUID().UUIDString
        
        super.init()
        
        self.task = self.createDataTask()
        self.task!.resume()
    }
    
    func createDataTask() -> NSURLSessionDataTask{
        weak var weakSelf = self
        let tempTask = self.session.dataTaskWithRequest(self.urlRequest) { (data, response, responseError) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let mutableRequest = weakSelf!.urlRequest
            
            if httpResponse.statusCode == weakSelf!.expectedStatus{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    weakSelf!.successBlock(data)
                    weakSelf!.delegate?.sessionRequestDidComplete(weakSelf!)
                })
            }
//            else if httpResponse.statusCode == 401{
//                // auth error case
//            }
            
            else{
                // error case
                var message = String(format: "Unexpected response code: %d", httpResponse.statusCode)
                
                if let d = data{
                    do{
                        let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions(rawValue: 0))
                        if json != nil && json!.isKindOfClass(NSDictionary){
                            if let errorMessage = json!.valueForKey("error"){
                               message = errorMessage as! String
                            }
                        }
                    }
                    catch{
                        print("Error parsing: \(error)")
                    }
                }
                
                let error: NSError = NSError(domain: "MyCustomError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    weakSelf!.failureBlock(error)
                    weakSelf?.delegate?.sessionRequestFailed(weakSelf!, error: error)
                })
            }
        }
        return tempTask
    }
    
    func cancel(){
        self.task!.cancel()
        self.task = nil
    }
    
    func restart(){
        self.cancel()
        self.task = self.createDataTask()
        self.task!.resume()
    }
    
}