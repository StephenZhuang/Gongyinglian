//
//  ToolUtils.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-5.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class ToolUtils: NSObject {
    var isLogin: Bool {
    get {
       return NSUserDefaults.standardUserDefaults().boolForKey("isLogin")
    }
    set(newIsLogin) {
        NSUserDefaults.standardUserDefaults().setBool(newIsLogin, forKey: "isLogin")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    }
    
    var username: NSString {
    get {
        return NSUserDefaults.standardUserDefaults().objectForKey("username") as NSString
    }
    set(newUsername) {
        NSUserDefaults.standardUserDefaults().setObject(newUsername, forKey: "username")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    }
    
    var password: NSString {
    get {
        return NSUserDefaults.standardUserDefaults().objectForKey("password") as NSString
    }
    set(newPassword) {
        NSUserDefaults.standardUserDefaults().setObject(newPassword, forKey: "password")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    }
    
    var user: Login?
    
    class func shareInstance()->ToolUtils {
        struct Singleton{
            static var predicate: dispatch_once_t = 0
            static var instance: ToolUtils? = nil
        }
        dispatch_once(&Singleton.predicate,{
            Singleton.instance = ToolUtils()
            }
        )
        return Singleton.instance!
    }
    
    init() {
        super.init()
    }
}

