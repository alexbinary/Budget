
import Foundation



let preview_expenseCategory_default = Budget(id: UUID(), name: "Category 1")


let preview_dataModel_empty = DataModel(expenses: [])

let preview_dataModel_default = DataModel(
    
    expenses: [
    
        Expense(
            date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 10))!,
            amount: -12.34,
            label: "test1"
        ),
        
        Expense(
            date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 15))!,
            amount: +75,
            label: "test2"
        ),
        
        Expense(
            date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 5))!,
            amount: -10.99,
            label: "test3"
        ),
        
        Expense(
            date: Calendar(identifier: .iso8601).date(from: DateComponents(year: 2021, month: 7, day: 1))!,
            amount: -10.99,
            label: ""
        )
    ],
    
    budgets: [
    
        Budget(id: UUID(), name: "Category 1"),
        Budget(id: UUID(), name: "Category 2"),
        Budget(id: UUID(), name: "Category 3")
    ]
)


let preview_dataStore_emptyModel = MemoryDataStore(withModel: preview_dataModel_empty)

let preview_dataStore_defaultModel = MemoryDataStore(withModel: preview_dataModel_default)
