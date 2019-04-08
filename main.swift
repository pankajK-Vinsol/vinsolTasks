import Foundation

print("Enter count of number of prime values.")
var N = Int()
if let input = readLine(){
    if let count = Int(input){
        N = count
        print("print prime numbers upto \(count) values:")
    }
    else{
        print("No value entered")
    }
}


//let input = readLine()
//var count = Int(input ?? "")
//print("\(String(describing: count!))")
//
//var number : Int = 2
//let i: Int = 0
//var primeArray: [Int] = []
//var flag: Bool = false
//
//while i < count!{
//    for value in 2 ... 1000{
//        for index in 2 ... value{
//            if value % index == 0{
//                flag = false
//                break
//            }
//            else{
//                flag = true
//            }
//        }
//        if flag == true{
//            primeArray.append(value)
//            break
//        }
//    }
//    count! += 1
//}
//
//print("the first \(String(describing: count)) prime numbers are: \(primeArray)")

let maxP = 40
var isPrime: [Bool] = []
var primes: [Int] = []
for _ in 0...maxP {
    isPrime.append(true)
}
isPrime[0] = false
isPrime[1] = false
for i in 2...maxP {
    if isPrime[i] == true {
        var j = i*i
        while j <= maxP {
            isPrime[j] = false
            j += i
        }
        primes.append(i)
    }
}

for i in 0..<N {
    print(primes[i])
}
