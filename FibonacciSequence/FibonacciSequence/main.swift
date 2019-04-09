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
    fiboArray.append(1)
    fiboArray.append(1)
    for i in 2 ..< value{
        fiboArray.append(fiboArray[i - 1] + fiboArray[i - 2])
    }
    return fiboArray[value - 1]
}

print("Provide length of fibonacci sequence.")
if let input = readLine(){
    if let number = Int(input){
        print("So the \(number)th fibonacci number in sequence is:")
        let answer = fibonacciValue(number)
        print(answer)
    }
}
