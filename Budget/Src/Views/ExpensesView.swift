
import SwiftUI



struct ExpensesView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    
    private func format(_ date: Date) -> String {
       
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
    
    
    private func format(currency number: Double) -> String {

        let formatter = NumberFormatter()

        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: abs(number)))!
    }
    
    
    var body: some View {

        NavigationView {
            
            Group {
            
                let expenses = dataStore.dataModel?.expenses ?? []
                if expenses.isEmpty {
                
                    Text("No expenses")
                    
                } else {
                    
                    List {
                        ForEach(expenses) { expense in
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(format(expense.date))
                                        .font(.callout)
                                    Text(expense.label)
                                        .font(.caption)
                                }
                                Spacer()
                                Text(format(currency: expense.amount))
                                    .font(.headline)
                                    .foregroundColor(expense.isGoingOut ? .red : .green)
                            }
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