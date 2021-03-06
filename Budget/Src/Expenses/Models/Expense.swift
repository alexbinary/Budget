
import Foundation



struct Expense: Codable, Identifiable {

    
    var id: UUID
    var date: Date
    var amount: Double
    var label: String?
    
    var direction: ExpenseDirection { amount < 0 ? .goingOut : .comingIn }
    var isGoingOut: Bool { direction == .goingOut }
    
    var budget: Budget?
    
    
    init(id: UUID? = nil, date: Date, amount: Double, label: String? = nil, budget: Budget? = nil) {
        
        self.id = id ?? UUID()
        self.date = date
        self.amount = amount
        self.label = label
        self.budget = budget
    }
}



enum ExpenseDirection: CaseIterable, CustomStringConvertible {
 
    
    case comingIn
    case goingOut
    
    
    var description: String {
        
        switch self {
        
        case .comingIn:
            return "in"
            
        case .goingOut:
            return "out"
        }
    }
}
