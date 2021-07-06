
import SwiftUI



struct ExpensesView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    @State var editViewIsPresented: Bool = false
    
    
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
                                    Text(expense.label.isEmpty ? "no description" : expense.label)
                                        .font(.caption)
                                        .italic(expense.label.isEmpty)
                                        .foregroundColor(expense.label.isEmpty ? .secondary : .primary)
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
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            
                            self.editViewIsPresented = true
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                )
                .sheet(isPresented: self.$editViewIsPresented) {
                    
                    AddExpenseView()
                }
        }
    }
}



extension Text {
    
    
    func italic(_ active: Bool) -> Text {
        
        guard active else { return self }
        
        return italic()
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
