//https://open.163.com/movie/2015/2/S/4/MAIKHN60A_MAIOV9HS4.html
// 有数据结构和递归的讲解，建议没事可以复习复习
//  CalculatorBrain.swift
//  Calculator
//
//  Created by caihongguang on 2018/4/26.
//  Copyright © 2018年 SYJ. All rights reserved.
//

import  Foundation

//Model
class CalculatorBrain
{
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, (Double) -> Double)
        case BinaryOperation(String, (Double,Double) -> Double)
    }
    
    //栈
    private var opStack = [Op]()
    private var knowOps = Dictionary<String, Op>()
    
    init() {
        //这个句子结构应该可以简化，但是这里初学者还是写全，能简化 就简化吧
        knowOps["*"] = Op.BinaryOperation("*", { (s0, s1) -> Double in
            s0 * s1
        })
        
        knowOps["/"] = Op.BinaryOperation("/", { (s0, s1) -> Double in
            s1 / s0
        })
        
        knowOps["+"] = Op.BinaryOperation("+", { (s0, s1) -> Double in
            s0 + s1
        })
        
        knowOps["-"] = Op.BinaryOperation("-", { (s0, s1) -> Double in
            s0 - s1
        })
        
        knowOps["平方"] = Op.BinaryOperation("平方", { (s0, s1) -> Double in
            sqrt(s0)
        })
        
        
        
    }
    
    
    //默认 ops前面有个 let ,我们可以修改为 var ,这样就有个可变的copy了。但是阅读起来会有些困惑，所以先加个局部变量
    private func evaluate(ops:[Op]) ->  (result: Double?,remainingOps: [Op])
    {
        if !ops.isEmpty{
            
            var remainingOps = ops
            //ops是传入进来的，只要你传入的不是类，都是实例，经过copy过的，不能操作。
            
            //swift里的数组和字典在类里不是类是 结构体，但是拥有类的大部分功能。
            //两大重要的区别:
            // 类可以继承，结构体不可以。
            // 结构体传递的是值，类传递的是引用
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand,remainingOps)
                
            case .UnaryOperation(_,let operation):
                
                let operandEvaluation = evaluate(ops: remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand),operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_,let operation):
                let op1Evaluation = evaluate(ops: remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(ops: op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2), op2Evaluation.remainingOps)
                    }
                }
                
            }
            
        }
        
        return (nil,ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(ops: opStack)
        return result
    }
    
    func pushOperand(operand:Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    
    func perforOperation(symbol:String) ->Double? {
        if let operation = knowOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
}








