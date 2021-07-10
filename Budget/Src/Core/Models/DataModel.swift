
import Foundation



struct DataModel: Codable {
    
    
    var expenses: [Expense] = []
    
    var budgets: [Budget] = []
    
    
    func lastExpenses(in budget: Budget) -> [Expense] {
        
        return expenses.filter { $0.budget?.id == budget.id }
    }
}
