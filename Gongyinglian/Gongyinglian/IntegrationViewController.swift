//
//  IntegrationViewController.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-7.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class IntegrationViewController: UITableViewController {
    var dataArray: NSMutableArray?
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.addTitleView(title: "积分", subtitle: "兑换历史")
        
        self.dataArray = NSMutableArray()
        self.refreshControl.addTarget(self, action: Selector("refreshControlValueChanged"), forControlEvents: .ValueChanged)
        self.refreshControl!.beginRefreshing()
        loadData()

    }
    func refreshControlValueChanged() {
        if self.refreshControl.refreshing {
            loadData()
        }
    }
    
    func loadData() {
        var params: NSMutableDictionary = NSMutableDictionary()
        var dic: NSMutableDictionary = NSMutableDictionary()
        dic.setObject("com.shqj.webservice.entity.UserKey", forKey: "class")
        dic.setObject(ToolUtils.shareInstance().user!.key, forKey: "key")
        let jsonString: NSString = dic.JSONString()
        params.setObject(jsonString, forKey: "userkey")
        var webservice: WebServiceRead = WebServiceRead()
        webservice = WebServiceRead(self , selecter:Selector("webServiceFinished:"))
        webservice.postWithMethodName("doQueryJdk", params: params)
    }
    
    func webServiceFinished(data: NSString) {
        var dic: NSDictionary = data.objectFromJSONString() as NSDictionary
        var jdkList: QueryJdkList = QueryJdkList()
        jdkList.build(dic)
        self.dataArray!.removeAllObjects()
        self.dataArray!.addObjectsFromArray(jdkList.data)
        self.tableView!.reloadData()
        
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.dataArray!.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell : GoodsCell! = tableView!.dequeueReusableCellWithIdentifier("cell") as GoodsCell
        
        // Configure the cell...
        var queryjdk:QueryJdk = self.dataArray!.objectAtIndex(indexPath!.row) as QueryJdk
        cell.nameLabel.text = queryjdk.jf?.stringValue
        cell.codeLabel.text = queryjdk.jfbak?.stringValue
        cell.countLabel.text = queryjdk.rq?
        return cell
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
