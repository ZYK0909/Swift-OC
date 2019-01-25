//
//  BackViewController.swift
//  SwiftCode
//
//  Created by ZYK on 2018/5/12.
//  Copyright © 2018年 ZYK. All rights reserved.
//

import UIKit



let thankTableHeadViewHeight = 300.0

class BackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var thanksTableView: UITableView?
    var thanksImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initThanksTableView()
    }

    private func initThanksTableView() {
        thanksTableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        thanksTableView?.backgroundColor = UIColor.white
        thanksTableView?.delegate = self
        thanksTableView?.dataSource = self
        
        //headView
        let thanksHeadView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Double(ScreenWidth), height: thankTableHeadViewHeight))
        thanksImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: Double(ScreenWidth), height: thankTableHeadViewHeight))
        thanksImageView?.image = UIImage(named:"thanks")
        thanksHeadView.addSubview(thanksImageView!)
        thanksTableView?.tableHeaderView = thanksHeadView
        view.addSubview(thanksTableView!)
    }
    //MARK: thanksTableView 代理 数据源
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "各位大佬辛苦了，小❤️❤️送给你们🤣🤣"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = CGFloat(scrollView.contentOffset.y)
        print("\(offsetY)")
        if offsetY < 0 {
            let totalOffsetY = CGFloat(thankTableHeadViewHeight) + abs(offsetY)
            let f = CGFloat(totalOffsetY / CGFloat(thankTableHeadViewHeight))
            self.thanksImageView?.frame = CGRect(x: -(ScreenWidth * f - ScreenWidth) / 2, y: offsetY, width: ScreenWidth * f, height: totalOffsetY)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
