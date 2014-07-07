//
//  UIViewController+titleView.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-7.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import Foundation

extension UIViewController {
    func addTitleView(#title: NSString , subtitle: NSString) {
        self.navigationController.navigationBar.backgroundColor = UIColor.RGBColor(red: 38, green: 161, blue: 234)
        self.navigationController.navigationBar.tintColor = UIColor.RGBColor(red: 38, green: 161, blue: 234)
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            self.navigationController.navigationBar.barTintColor = UIColor.RGBColor(red: 38, green: 161, blue: 234)
        }
        self.navigationController.navigationBar.alpha = 1
        
        var titleView: TitleView = (NSBundle.mainBundle().loadNibNamed("TitleView", owner: self, options: nil) as NSArray).firstObject as TitleView
        titleView.title = title
        titleView.subTitle = subtitle
        self.navigationItem.titleView = titleView
        
        var item: UIBarButtonItem = UIBarButtonItem(title:"", style:UIBarButtonItemStyle.Plain, target:nil, action:nil)
        var image: UIImage = UIImage(named: "back").resizableImageWithCapInsets(UIEdgeInsetsMake(0, 25, 0, 0))
        item.setBackButtonBackgroundImage(image, forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        self.navigationItem.backBarButtonItem = item
//        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, -1000) , forBarMetrics: UIBarMetrics.Default)
        //        var button: UIButton = UIButton()
        //        button.frame = CGRectMake(0, 0, 20, 30)
        //        button.setImage(UIImage(named: "返回"), forState: UIControlState.Normal)
        //        button.addTarget(self, action: Selector("backAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        //        var item: UIBarButtonItem = UIBarButtonItem(customView: button)
        //        self.navigationItem.backBarButtonItem = item
        
    }
    
    func backAction(sender: UIButton) {
        self.navigationController.popViewControllerAnimated(true)
    }
}