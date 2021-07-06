
import SwiftUI



struct ExpensesView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    
    var body: some View {

        NavigationView {
            
            Group {
            
                let expenses = dataStore.dataModel?.expenses ?? []
                if expenses.isEmpty {
                
                    Text("No expenses")
                    
                } else {
                    
                    List {
                        ForEach(expenses) { expense in
                            Text(expense.label)
                        }
                    }
                }
            }
                .navigationTitle("Expenses")
        }
    }
}



struct ExpensesView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
        
            ExpensesView()
                .environmentObject(preview_dataStore_defaultModel as DataStore)
                .previewDisplayName("Default model")
            
            ExpensesView()
                .environmentObject(preview_dataStore_emptyModel as DataStore)
                .previewDisplayName("Empty model")
        }
    }
}
