
import SwiftUI



struct ExpensesView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    @State var editViewIsPresented: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            
            let expenses = dataStore.dataModel?.expenses ?? []
            
            Group {
            
                if expenses.isEmpty {
                
                    Text("No expenses")
                    
                } else {
                    
                    List {
                        
                        ForEach(expenses.sorted(by: { $0.date > $1.date })) { expense in
                            
                            NavigationLink(
                                destination: EditExpenseView(
                                    expenseId: expense.id,
                                    expenseViewModel: EditExpenseViewModel(from: expense)
                                ),
                                label: {
                                    ExpenseListItemView(expense: expense)
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
