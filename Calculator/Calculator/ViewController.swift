
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    
    var userIsInTheMiddleOfTypeingANumber : Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypeingANumber{
            display.text = display.text! + digit
            
        }else
        {
            display.text = digit
            userIsInTheMiddleOfTypeingANumber = true
        }
        
        
    }
    
    @IBAction func operate(_ sender: UIButton) {
        
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypeingANumber{
            enter()
        }
        
        
        
        switch operation {
        //也支持图片类型，比如你的按钮是个图片，可以写名字
        case "*":
            performOperation (operation: { (op1, op2)  in
                return op1 * op2
            })
            //后面除前面 
        case "/":
            performOperation (operation: { (op1, op2)  in
                return op1 / op2
            })
            
        case "+":
            performOperation (operation: { (op1, op2)  in
                return op1 + op2
            })
        case "-":
            performOperation (operation: { (op1, op2)  in
                return op1 - op2
            })
        default:
            break
        }
        
    }
    
    func performOperation(operation: (Double,Double) ->Double)
    {
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        
        
        
        userIsInTheMiddleOfTypeingANumber = false
        operandStack.append(displayValue)
        print(operandStack)
        
    }
    
    var displayValue: Double {
        get {
            //利用文档查看意思
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            
            display.text = "\(newValue)"
            
            userIsInTheMiddleOfTypeingANumber = false
            
            
        }
    }
    
    
    
    
}



















// https://open.163.com/movie/2015/2/3/4/MAIKHN60A_MAIKJBI34.html 视频
//  ViewController.swift
//  Calculator
//
//  Created by caihongguang on 2018/4/25.
//  Copyright © 2018年 SYJ. All rights reserved.
//swift 一目了然看哪个是 变量 常量 大大增加了可阅读性
//成为一个好的开发者阅读文档是非常重要的 按 option点击 然后看more 查看文档


//不能初始化没有值的对象 必须给个值 nil或者默认值
//类型推导   swift是非常强类型的语言
// 可选值 一种是 未设 状态 比如 nil,
//另一种 有值 就是查看的时候 ?号前面的
// display.text 是一个 optional String 不是String类型 所以不能直接加 通过解包把它变成String有值，没值就会崩溃


