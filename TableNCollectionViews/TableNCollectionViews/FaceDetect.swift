//
//  FaceDetect.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 4/2/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class FaceDetect: NSObject {

    enum FaceDetectError: ErrorType{
        case CouldNotDownloadImage
    }
    
    class func faceForPerson(person: String, size: CGSize, completion: (image: UIImage?, imageFound: Bool)-> ()) throws {
        let escapedString = person.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let sizeForRequest = Int(max(size.height, size.width))
        let url = NSURL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedString!)&prop=pageimages&format=json&pithumbsize=\(sizeForRequest)")
        print(url)
        let task: NSURLSessionTask? = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil{
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print(responseDictionary)
                
            }
        })
        
        task!.resume()
    }
}
