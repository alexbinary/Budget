
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
            
            let expenses = dataStore.dataModel?.expenses ?? []
            
            Group {
            
                if expenses.isEmpty {
                
                    Text("No expenses")
                    
                } else {
                    
                    List {
                        
                        ForEach(expenses.sorted(by: { $0.date > $1.date })) { expense in
                            
                            let expenseViewModel = ShowExpenseViewModel(from: expense)
                            
                            NavigationLink(
                                destination: EditExpenseView(
                                    expenseId: expense.id,
                                    expenseViewModel: EditExpenseViewModel(from: expense)
                                ),
                                label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(format(expenseViewModel.date))
                                                .font(.callout)
                                            Text(expenseViewModel.label.isEmpty ? "no description" : expenseViewModel.label)
                                                .font(.caption)
                                                .italic(expenseViewModel.label.isEmpty)
                                                .foregroundColor(expenseViewModel.label.isEmpty ? .secondary : .primary)
                                        }
                                        Spacer()
                                        Text(format(currency: expenseViewModel.amount))
                                            .font(.headline)
                                            .foregroundColor(expenseViewModel.isGoingOut ? .red : .green)
                                    }
                                }
                            )
                        }
                        .onDelete { indexSet in
                         
                            self.dataStore.removeExpenses(atOffsets: indexSet)
                        }
                    }
                }
            }
                .navigationTitle("Expenses")
                .navigationBarItems(trailing:
                    HStack {
                        expenses.isEmpty ? nil : EditButton()
                        Button(action: {
                            
                            self.editViewIsPresented = true
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                )
                .sheet(isPresented: self.$editViewIsPresented) {
                    
                    NavigationView {
                        EditExpenseView(
                            expenseId: nil,
                            expenseViewModel: EditExpenseViewModel.empty
                        )
                    }
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
            
            ExpensesView()
                .environmentObject(preview_dataStore_emptyModel as DataStore)
                .previewDisplayName("Empty")
        }
    }
}
