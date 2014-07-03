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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, animations: {
            
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

