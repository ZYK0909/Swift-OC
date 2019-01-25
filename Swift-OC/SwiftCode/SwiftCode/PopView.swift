//
//  PopView.swift
//  SwiftCode
//
//  Created by ZYK on 2018/4/24.
//  Copyright © 2018年 ZYK. All rights reserved.
//

import UIKit
import pop

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
private let buttonWidth: CGFloat = 80.0
private let buttonHeight: CGFloat = 110.0

class PopView: UIView {
    
    var presentClosure: (()->())?
    
    lazy var imageArray : [String] = ["xie","local","xin","music","save","dian"]   //图片数组
    lazy var buttonArray: [UIButton] = [UIButton]()  //按钮数组
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.backgroundColor = UIColor.white
        addButtonToView()
    }
    
    //MARK: 添加按钮
    private func addButtonToView() {
        let buttonMargin = (ScreenWidth - 3 * buttonWidth) / 4
        for i in 0..<6 {
            let button = UIButton()
            let coloumIndex = i % 3
            let rowIndex = i / 3
            let buttonX = buttonMargin + (buttonWidth + buttonMargin) * CGFloat(coloumIndex)
            let buttonY = (buttonMargin + buttonHeight) * CGFloat(rowIndex) + ScreenHeight
            button.setImage(UIImage(named:imageArray[i]), for: .normal)
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            self.addSubview(button)
            buttonArray.append(button)
            button.addTarget(self, action: #selector(didButtonClick(button:)), for: .touchUpInside)
        }
    }
    
    //MARK: 按钮点击事件 被点击的放大 其他缩小
    @objc private func didButtonClick(button: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            for musicButton in self.buttonArray {
                if button == musicButton {
                    musicButton.transform = CGAffineTransform.init(scaleX: 2, y: 2)
                }
                else {
                    musicButton.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
                    musicButton.alpha = 0.1
                }
            }
        }, completion: { (_)->() in
            if self.presentClosure != nil {
                self.presentClosure!()
            }
            self.removeFromSuperview()
        })
    }
    //外部调用加载View
    func showView(VC:UIViewController) {
        VC.view.addSubview(self)
        //开始动画
        for (index,button) in buttonArray.enumerated() {
            self.buttonAnimation(button: button, index: index, isShow: true)
        }
    }
    
    //MARK: 按钮动画
    private func buttonAnimation(button: UIButton,index: Int,isShow: Bool = true) {
        //pop动画
        let springAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        springAnimation?.springBounciness = 10.0
        springAnimation?.springSpeed = 5
        //延迟时间
        springAnimation?.beginTime = CACurrentMediaTime() + Double(index) * 0.025
        let buttonCenterY = button.center.y + CGFloat(isShow ? -350 : 350)
        springAnimation?.toValue = NSValue.init(cgPoint: CGPoint(x: button.center.x, y: buttonCenterY))
        button.pop_add(springAnimation, forKey: nil)
    }
    //MARK: 点击移除
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //结束动画，0.5秒后移除 反向遍历数组
        for (index,button) in buttonArray.reversed().enumerated() {
            self.buttonAnimation(button: button, index: index, isShow: false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
            self.removeFromSuperview()
        })
    }
}
