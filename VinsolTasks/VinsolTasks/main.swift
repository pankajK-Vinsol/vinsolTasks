import Foundation

var primeArray: [Int] = []
var index: Int = 0
var start: Int = 2
var flag: Bool = true

print("Enter count of number of prime values.")
if let input = readLine(){
    if let count = Int(input){
        print("print prime numbers upto \(count) values:")
        while index < count{
            for i in 2 ..< start{
                if start % i == 0{
                    flag = false
                    break
                }
                else{
                    flag = true
                }
            }
            if flag == true{
                primeArray.append(start)
                index += 1
            }
            start += 1
        }
        print(primeArray)
    }
    else{
        print("No value entered")
    }
}
