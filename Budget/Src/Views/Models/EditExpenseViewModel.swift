
import Foundation



struct EditExpenseViewModel {
    
    
    var date: Date = Date()
    var amount: String = ""
    var direction: ExpenseDirection = .goingOut
    var label: String = ""
    
    
    static var empty = EditExpenseViewModel()
    
    
    init() {
    }
    
    
    init(from expense: Expense) {
        
        self.date = expense.date
        self.amount = "\(abs(expense.amount))"
        self.direction = expense.direction
        self.label = expense.label ?? ""
    }

    
    func expense(withId id: UUID?) -> Expense {
        
        Expense(
            id: id,
            date: date,
            amount: Double(amount)! * (direction == .goingOut ? -1 : +1),
            label: label.isEmpty ? nil : label
        )
    }
}
