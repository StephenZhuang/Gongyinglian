//
//  SoldViewController.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-7.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class SoldViewController: UITableViewController {
    var dataArray: NSMutableArray?
    var mdArray: NSMutableArray?
    var scanCode: NSString = ""
    var isSell: Bool = true
    @IBOutlet var codeTextField: UITextField?
    @IBOutlet var topView: UIView?
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView!.frame.size.height = 44
        if isSell {
            self.addTitleView(title: "售出", subtitle: "售出查询")
        } else {
            self.addTitleView(title: "退货", subtitle: "退货查询")
        }
        
        self.dataArray = NSMutableArray()
        self.mdArray = NSMutableArray()
        self.refreshControl.addTarget(self, action: Selector("refreshControlValueChanged"), forControlEvents: .ValueChanged)
//        self.refreshControl!.beginRefreshing()
//        loadData()
        
    }
    func refreshControlValueChanged() {
        if self.refreshControl.refreshing {
            loadData()
        }
    }
    
    func loadData() {
        var params: NSMutableDictionary = NSMutableDictionary()
        var dic: NSMutableDictionary = NSMutableDictionary()
        dic.setObject("com.shqj.webservice.entity.UserKeyAndSMCode", forKey: "class")
        dic.setObject(scanCode, forKey: "smcode")
        dic.setObject(ToolUtils.shareInstance().user!.key, forKey: "key")
        let jsonString: NSString = dic.JSONString()
        params.setObject(jsonString, forKey: "str")
        var webservice: WebServiceRead = WebServiceRead()
        webservice = WebServiceRead(self , selecter:Selector("webServiceFinished:"))
        webservice.postWithMethodName("doQueryCKBySMM", params: params)
        
        if ToolUtils.shareInstance().user!.usertype.toInt() == 1 {
            loadMD()
        }
    }
    
    func webServiceFinished(data: NSString) {
        var dic: NSDictionary = data.objectFromJSONString() as NSDictionary
        var jdkList: QueryCKBySMMList = QueryCKBySMMList()
        jdkList.build(dic)
        self.dataArray!.removeAllObjects()
//        var range: NSRange = data.rangeOfString("null")
//        if(range.location == NSIntegerMax) {
            self.dataArray!.addObjectsFromArray(jdkList.data)
//        }
        self.tableView!.reloadData()
        
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadMD() {
        var params: NSMutableDictionary = NSMutableDictionary()
        var dic: NSMutableDictionary = NSMutableDictionary()
        dic.setObject("com.shqj.webservice.entity.UserKeyAndSMCode", forKey: "class")
        dic.setObject(scanCode, forKey: "smcode")
        dic.setObject(ToolUtils.shareInstance().user!.key, forKey: "key")
        let jsonString: NSString = dic.JSONString()
        params.setObject(jsonString, forKey: "userkey")
        var webservice: WebServiceRead = WebServiceRead()
        webservice = WebServiceRead(self , selecter:Selector("loadMDFinished:"))
        webservice.postWithMethodName("doQueryALLkc", params: params)
    }
    
    func loadMDFinished(data: NSString) {
        var dic: NSDictionary = data.objectFromJSONString() as NSDictionary
        var jdkList: QueryXjCKList = QueryXjCKList()
        jdkList.build(dic)
        self.mdArray!.removeAllObjects()
//        var range: NSRange = data.rangeOfString("null")
//        if(range.location == NSIntegerMax) {
            self.mdArray!.addObjectsFromArray(jdkList.data)
//        }
        self.tableView!.reloadData()
        
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func sellAction(sender: UIButton?) {
            var params: NSMutableDictionary = NSMutableDictionary()
            var dic: NSMutableDictionary = NSMutableDictionary()
            dic.setObject("com.shqj.webservice.entity.Userxsck", forKey: "class")
            dic.setObject(scanCode, forKey: "smcode")
        if (ToolUtils.shareInstance().user!.usertype.toInt() == 1) {
            var queryckbysmm:QueryXjCK = self.mdArray!.objectAtIndex(sender!.tag) as QueryXjCK
            dic.setObject(queryckbysmm.key, forKey: "mdkey")
        } else {
            dic.setObject("a", forKey: "mdkey")
        }
        if isSell {
            dic.setObject("a", forKey: "isth")
        } else {
            dic.setObject("Y", forKey: "isth")
        }
        
            dic.setObject(ToolUtils.shareInstance().user!.key, forKey: "key")
            let jsonString: NSString = dic.JSONString()
            params.setObject(jsonString, forKey: "userxmck")
            var webservice: WebServiceRead = WebServiceRead()
            webservice = WebServiceRead(self , selecter:Selector("sellFinished:"))
            webservice.postWithMethodName("doXsck", params: params)
    }
    
    func sellFinished(data: NSString) {
//        println(data)
        if isSell {
            ProgressHUD.showSuccess("售出成功")
        } else {
            ProgressHUD.showSuccess("退货成功")
        }
    }
    
    @IBAction func goToQRImageController() {
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            var vc: Ios7QRViewController = Ios7QRViewController()
            vc.scanBlock = {
                (NSString code) in
                self.scanCode = code
                self.codeTextField!.text = code
                self.loadData()
            }
            self.navigationController.pushViewController(vc ,animated:true)
        } else {
            var vc: Ios6QRViewController = Ios6QRViewController()
            vc.scanBlock = {
                (NSString code) in
                self.scanCode = code
                self.codeTextField!.text = code
                self.loadData()
            }
            self.navigationController.pushViewController(vc ,animated:true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        self.scanCode = textField.text
        self.loadData()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return self.dataArray!.count
        } else {
            return self.mdArray!.count
        }
    }
    
    override func tableView(tableView: UITableView?, heightForRowAtIndexPath indexPath: NSIndexPath?) -> CGFloat {
        if indexPath!.section == 0 {
            return 97
        }
        return 71
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        if (indexPath!.section == 0) {
            let cell : GoodsCell! = tableView!.dequeueReusableCellWithIdentifier("cell") as GoodsCell
            
            // Configure the cell...
            var queryckbysmm:QueryCKBySMM = self.dataArray!.objectAtIndex(indexPath!.row) as QueryCKBySMM
            cell.nameLabel.text = queryckbysmm.spname?
            cell.codeLabel.text = queryckbysmm.spcode?
            cell.countLabel.text = queryckbysmm.spcount?.stringValue
            if (ToolUtils.shareInstance().user!.usertype.toInt() == 1) {
                cell.sellButton.hidden = true
            } else {
                cell.sellButton.hidden = false
            }
            if isSell {
                cell.sellButton.titleLabel.text = "售出"
            } else {
                cell.sellButton.titleLabel.text = "退货"
            }
            return cell
        } else {
            let cell : GoodsCell! = tableView!.dequeueReusableCellWithIdentifier("mdcell") as GoodsCell
            
            // Configure the cell...
            var queryckbysmm:QueryXjCK = self.mdArray!.objectAtIndex(indexPath!.row) as QueryXjCK
            cell.nameLabel.text = queryckbysmm.mdname?
            cell.countLabel.text = queryckbysmm.spcount?.stringValue
            cell.sellButton.tag = indexPath!.row
            return cell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
