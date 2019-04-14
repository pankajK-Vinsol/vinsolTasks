
import Foundation

enum CalculatorOperation {
    case add
    case subtract
    case multiply
    case divide
    init?(from buttonTitle: String) {
        switch buttonTitle {
        case "+": self = .add
        case "-": self = .subtract
        case "*": self = .multiply
        case "/": self = .divide
        default: return nil
        }
    }
    
    func apply(to left: Int, and right: Int) -> Int {
        switch self {
        case .add:
            return left + right
        case .subtract:
            return left - right
        case .multiply:
            return left * right
        case .divide:
            if right == 0 {
                return 0
            } else {
                return left / right
            }
        }
    }
}
