
import Foundation



struct Budget: Codable, Identifiable {
    
    
    let id: UUID
    let name: String
    
    
    init(id: UUID?, name: String) {
        
        self.id = id ?? UUID()
        self.name = name
    }
}
