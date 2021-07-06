
import Foundation



let preview_dataModel_empty = DataModel(expenses: [])

let preview_dataModel_default = DataModel(expenses: [
    
    Expense(
        date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 1))!,
        amount: -12.34,
        label: "test1"
    ),
    
    Expense(
        date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 5))!,
        amount: +75,
        label: "test2"
    ),
    
    Expense(
        date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 6))!,
        amount: -10.99,
        label: "test3"
    )
])


let preview_dataStore_emptyModel = MemoryDataStore(withModel: preview_dataModel_empty)

let preview_dataStore_defaultModel = MemoryDataStore(withModel: preview_dataModel_default)
