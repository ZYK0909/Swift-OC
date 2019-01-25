//
//  ViewController.swift
//  SwiftCode
//
//  Created by ZYK on 2018/4/19.
//  Copyright © 2018年 ZYK. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createAddButton()
    }
    //MARK: 创建按钮
    private func createAddButton() {
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named:"add"), for: .normal)
        addButton.setBackgroundImage(UIImage(named:"addbg"), for: .normal)
        addButton.sizeToFit()
        addButton.addTarget(self, action: #selector(didAddButtonClick), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    //MARK: 按钮点击事件
    @objc private func didAddButtonClick() {
        print("我被点击了")
        let addView = PopView()
        addView.showView(VC: self)
//        weak var weakself = self
//        addView.presentClosure = { [weak self] in
//            let VC = PresentBackViewController()
//            self?.present(VC, animated: true, completion: nil)
//        }
//        weak var weakself = self
        addView.presentClosure = { [weak self] in
            let VC = BackViewController()
            self?.present(VC, animated: true, completion: nil)
        }
    }
}



