
import Foundation



struct Budget: Codable, Identifiable, Hashable {
    
    
    let id: UUID
    let name: String
    let amount: Double?
    
    
    init(id: UUID?, name: String, amount: Double? = nil) {
        
        self.id = id ?? UUID()
        self.name = name
        self.amount = amount
    }
}
