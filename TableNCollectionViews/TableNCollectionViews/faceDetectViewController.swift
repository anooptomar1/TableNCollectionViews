//
//  faceDetectViewController.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 4/2/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class faceDetectViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var faceImg: UIImageView!
    @IBOutlet weak var inputbox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputbox.delegate = self
        
        NSOperationQueue().addOperationWithBlock { 
            let url = NSURL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=calculator&prop=pageimages&format=json&pithumbsize=200")
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let textContent = textField.text{
            do {
                try FaceDetect.faceForPerson(textContent, size: CGSizeMake(200, 200), completion: { (image, imageFound) in
                    //
                })
            }catch FaceDetect.FaceDetectError.CouldNotDownloadImage{
                print("no image found")
            }catch{
                print(error)
            }
        }
        return true
    }

}
