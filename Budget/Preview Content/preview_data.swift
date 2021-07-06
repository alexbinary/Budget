
import Foundation



let preview_dataModel_empty = DataModel(expenses: [])

let preview_dataModel_default = DataModel(expenses: [
    
    Expense(
        date: Date.init(timeIntervalSinceReferenceDate: 3000),
        amount: 12.34,
        label: "test1"
    )
])


let preview_dataStore_emptyModel = MemoryDataStore(withModel: preview_dataModel_empty)

let preview_dataStore_defaultModel = MemoryDataStore(withModel: preview_dataModel_default)
