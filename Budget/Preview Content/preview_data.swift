
import Foundation



let preview_budget_default = Budget(id: UUID(), name: "Budget test")


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
    
        Budget(id: UUID(), name: "Budget 1", amount: 50),
        Budget(id: UUID(), name: "Budget 2", amount: nil),
        Budget(id: UUID(), name: "Budget 3", amount: 200)
    ]
)


let preview_dataStore_emptyModel = MemoryDataStore(withModel: preview_dataModel_empty)

let preview_dataStore_defaultModel = MemoryDataStore(withModel: preview_dataModel_default)
