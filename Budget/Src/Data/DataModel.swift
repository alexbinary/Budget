
import Foundation



struct DataModel: Codable {
    
    var expenses: [Expense] = []
}



struct Expense: Codable, Identifiable {
    
    var id: UUID = UUID()
    var date: Date
    var amount: Double
    var label: String
}
