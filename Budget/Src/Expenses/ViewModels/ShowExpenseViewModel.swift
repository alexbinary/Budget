
import Foundation



struct ShowExpenseViewModel {
    
    
    var date: Date
    var amount: Double
    var label: String
    
    var direction: ExpenseDirection { amount < 0 ? .goingOut : .comingIn }
    var isGoingOut: Bool { direction == .goingOut }
    
    
    init(from expense: Expense) {
        
        self.date = expense.date
        self.amount = expense.amount
        self.label = expense.label ?? ""
    }
}
