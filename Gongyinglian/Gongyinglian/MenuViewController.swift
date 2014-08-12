//
//  MenuViewController.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-5.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController ,UICollectionViewDataSource ,UICollectionViewDelegate {
    @IBOutlet var menuCollectionView: UICollectionView?
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addTitleView(title: "", subtitle: "")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func logoutAction() {
        ToolUtils.shareInstance().isLogin = false
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        if (ToolUtils.shareInstance().user!.usertype.toInt() == 1) {
            return 3
        }
        return 4
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell: MenuCell! = collectionView.dequeueReusableCellWithReuseIdentifier("MenuCell", forIndexPath: indexPath) as MenuCell
        switch indexPath.row {
        case 0:
            cell.contentView.backgroundColor = UIColor.RGBColor(red: 255, green: 84, blue: 10)
            cell.titleLabel.text = "库存查询"
        case 1:
            cell.contentView.backgroundColor = UIColor.RGBColor(red: 148, green: 103, blue: 249)
            cell.titleLabel.text = "售出"
        case 2:
            if (ToolUtils.shareInstance().user!.usertype.toInt() == 1) {
                cell.titleLabel.text = "兑换历史"
            } else {
                cell.titleLabel.text = "退货"
            }
            cell.contentView.backgroundColor = UIColor.RGBColor(red: 25, green: 138, blue: 250)
        default:
            cell.contentView.backgroundColor = UIColor.RGBColor(red: 98, green: 203, blue: 17)
            cell.titleLabel.text = "兑换历史"
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, viewForSupplementaryElementOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionReusableView! {
        var view: UICollectionReusableView?;
        if (kind == UICollectionElementKindSectionHeader) {
            view = collectionView!.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as? UICollectionReusableView
        } else {
            view = collectionView!.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath) as? UICollectionReusableView
        }
        return view
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("kucun", sender: nil)
        case 1:
            self.performSegueWithIdentifier("shouchu", sender: nil)
        case 2:
            if (ToolUtils.shareInstance().user!.usertype.toInt() == 1) {
                self.performSegueWithIdentifier("jifen", sender: nil)
            } else {
                self.performSegueWithIdentifier("tuihuo", sender: nil)
            }

        default:
            self.performSegueWithIdentifier("jifen", sender: nil)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue!.identifier == "tuihuo" {
            let vc: SoldViewController = segue!.destinationViewController as SoldViewController
            vc.isSell = false
        }
    }
    

}
