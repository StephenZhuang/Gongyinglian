//
//  ViewController.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-3.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
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
            
//            self.imageView!.transform = CGAffineTransformMakeTranslation(0, 100)
            rect = self.loginView!.frame
            rect.origin.y = 180
            self.loginView!.frame = rect
            
//            self.loginView!.transform = CGAffineTransformMakeTranslation(0, 180)
            }, completion: {
                (Bool completion) in
                if completion {
                    if ToolUtils.shareInstance().isLogin {
                        self.usernameTextField!.text = ToolUtils.shareInstance().username
                        self.passwordTextField!.text = ToolUtils.shareInstance().password
                        self.loginAction()
                    }
                }
            })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if textField.isEqual(self.usernameTextField) {
            self.passwordTextField!.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginAction() {
        self.view.endEditing(true)
        var username: NSString = self.usernameTextField!.text
        var password: NSString = self.passwordTextField!.text
        
        var params: NSMutableDictionary = NSMutableDictionary()
        var dic: NSMutableDictionary = NSMutableDictionary()
        dic.setObject("com.shqj.webservice.entity.UserInfo", forKey: "class")
        dic.setObject(username, forKey: "usercode")
        dic.setObject(password, forKey: "userpwd")
        let jsonString: NSString = dic.JSONString()
        params.setObject(jsonString, forKey: "userinfo")
        var webservice: WebServiceRead = WebServiceRead()
        webservice = WebServiceRead(self , selecter:Selector("webServiceFinished:"))
        webservice.showLoading = true
        webservice.postWithMethodName("doLogin", params: params)
    }
    
    func webServiceFinished(data: NSString) {
        var dic: NSDictionary = data.objectFromJSONString() as NSDictionary
        var login: Login = Login()
        login.build(dic)

//        let returntype: Int = login.returntype.toInt()!
        if (login.returntype.toInt() == 1) {
            ProgressHUD.showSuccess("登录成功")
            
            ToolUtils.shareInstance().username = self.usernameTextField!.text
            ToolUtils.shareInstance().password = self.passwordTextField!.text
            ToolUtils.shareInstance().isLogin = true
            ToolUtils.shareInstance().user = login
            
            self.performSegueWithIdentifier("login", sender: nil)
        } else {
            ProgressHUD.showError(login.key)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

