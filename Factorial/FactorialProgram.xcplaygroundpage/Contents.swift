
func factorial(_ value: Int) -> Int{
    if value == 1{
        return 1
    }
    else{
        return value * factorial(value - 1)
    }
}

// you can calculate factorial of any value entered in the function.
print("The factorial is:", factorial(8))
