
import Foundation



struct EditBudgetViewModel {
    
    
    var name: String = ""
    var amount: String = ""
    
    
    static var empty = EditBudgetViewModel()
    
    
    init() {
    }
    
    
    init(from budget: Budget) {
        
        self.name = budget.name
        self.amount = budget.amount != nil ? "\(budget.amount!)" : ""
    }
    
    
    func budget(withId id: UUID?) throws -> Budget {
        
        guard let amountNumeric = Double(amount) else {
            throw "\"\(amount)\" could not be parsed as a number"
        }
        
        return Budget(
            id: id,
            name: self.name,
            amount: amountNumeric
        )
    }
}
