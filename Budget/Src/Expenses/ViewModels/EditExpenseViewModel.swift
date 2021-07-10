
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

    
    func expense(withId id: UUID?) throws -> Expense {
        
        guard let amountNumeric = Double(amount) else {
            throw "\"\(amount)\" could not be parsed as a number"
        }
        
        return Expense(
            id: id,
            date: self.date,
            amount: amountNumeric * (direction == .goingOut ? -1 : +1),
            label: self.label.isEmpty ? nil : self.label
        )
    }
}



extension String: Error {}
