
import Foundation



struct DataModel: Codable {
    
    var expenses: [Expense] = []
}



struct Expense: Codable, Identifiable {
    
    var id: UUID
    var title: String
    var amount: Double
    var date: Date
}
