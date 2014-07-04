//
//  ViewController.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-3.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var loginView: UIView?
    @IBOutlet var usernameTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var rect: CGRect = self.imageView!.frame
        UIView.animateWithDuration(0.5, animations: {
            rect.origin.y = 100
            self.imageView!.frame = rect
            
            rect = self.loginView!.frame
            rect.origin.y = 180
            self.loginView!.frame = rect
            })
    }
    
    @IBAction func loginAction() {
        var username: NSString = self.usernameTextField!.text
        var password: NSString = self.passwordTextField!.text
        
        var params: NSMutableDictionary = NSMutableDictionary()
//        params.setObject(username, forKey: "usercode")
//        params.setObject(password, forKey: "userpwd")
//        params.setObject("com.shqj.webservice.entity.UserInfo", forKey: "class")
        params.setObject("{\"class\":\"com.shqj.webservice.entity.UserInfo\",\"usercode\":\"1\",\"userpwd\":\"1\"}", forKey: "userinfo")
        
        var webservice: WebServiceRead = WebServiceRead()
        webservice = WebServiceRead(self , selecter:Selector("webServiceFinished:"))
//        webservice.delegate = self
//        webservice.mselector = Selector("webServiceFinished")
        webservice.postWithMethodName("doLogin", params: params)
    }
    
    func webServiceFinished(data: NSString) {
        print(data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

