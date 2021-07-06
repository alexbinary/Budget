
import Foundation



struct DataModel: Codable {
    
    var expenses: [Expense] = []
}



struct Expense: Codable, Identifiable {

    
    var id: UUID = UUID()
    var date: Date
    var amount: Double
    var label: String
    
    
    var direction: Direction { amount < 0 ? .goingOut : .comingIn }
    var isGoingOut: Bool { direction == .goingOut }
    
    enum Direction {
        
        case comingIn
        case goingOut
    }
}
