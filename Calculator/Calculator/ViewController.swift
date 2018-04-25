//
//  ViewController.swift
//  Calculator
//
//  Created by caihongguang on 2018/4/25.
//  Copyright © 2018年 SYJ. All rights reserved.
//swift 一目了然看哪个是 变量 常量 大大增加了可阅读性
//成为一个好的开发者阅读文档是非常重要的 按 option点击 然后看more 查看文档

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    //不能初始化没有值的对象 必须给个值 nil或者默认值
    var userIsInTheMiddleOfTypeingANumber : Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
        //类型推导   swift是非常强类型的语言
        // 可选值 一种是 未设 状态 比如 nil,
        //另一种 有值 就是查看的时候 ?号前面的
        let digit = sender.currentTitle!
        //        print(digit)
        
        if userIsInTheMiddleOfTypeingANumber{
            // display.text 是一个 optional String 不是String类型 所以不能直接加 通过解包把它变成String有值，没值就会崩溃
            display.text = display.text! + digit
            
        }else
        {
            display.text = digit
            userIsInTheMiddleOfTypeingANumber = true
        }
        
        
    }
    
}

