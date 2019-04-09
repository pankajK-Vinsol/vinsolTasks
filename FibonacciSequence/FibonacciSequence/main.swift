//
//  main.swift
//  FibonacciSequence
//
//  Created by Pankaj kumar on 09/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import Foundation

func fibonacciValue(_ value: Int) -> Int{
    var fiboArray: [Int] = []
    fiboArray = [1, 1]
    if value > 1{
        for i in 2 ..< value{
            fiboArray.append(fiboArray[i - 1] + fiboArray[i - 2])
        }
        return fiboArray[value - 1]
    }
    else if value > 0{
        return fiboArray[value]
    }
    else{
        return 0
    }
}

print("Provide length of fibonacci sequence.")
if let input = readLine(){
    if let number = Int(input){
        print("So the \(number)th fibonacci number in sequence is:")
        let answer = fibonacciValue(number)
        print(answer)
    }
}
