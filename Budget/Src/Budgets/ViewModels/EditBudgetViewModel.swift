
import Foundation



struct EditBudgetViewModel {
    
    
    var name: String = ""
    
    
    static var empty = EditBudgetViewModel()
    
    
    init() {
    }
    
    
    init(from budget: Budget) {
        
        self.name = budget.name
    }
    
    
    func budget(withId id: UUID?) -> Budget {
        
        return Budget(
            id: id,
            name: self.name
        )
    }
}
