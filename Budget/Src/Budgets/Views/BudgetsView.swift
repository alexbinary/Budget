
import SwiftUI



struct BudgetsView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    @State var editViewIsPresented: Bool = false
    
    
    var body: some View {

        NavigationView {
        
            let budgets = dataStore.dataModel?.budgets ?? []
            
            Group {
            
                if budgets.isEmpty {
                
                    Text("No budgets")
                    
                } else {
                    
                    List {
                        
                        ForEach(budgets) { budget in
                            
                            NavigationLink(
                                destination: EditBudgetView(
                                    budgetId: budget.id,
                                    budgetViewModel: EditBudgetViewModel(from: budget)
                                ),
                                label: {
                                    HStack {
                                        Text(budget.name)
                                        Spacer()
                                        
                                        if let amount = budget.amount {
                                            Text(Formatter.format(currency: amount))
                                                .font(.headline)
                                        } else {
                                            Text("no amount")
                                                .font(.caption)
                                                .italic()
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            )
                        }
                        .onDelete { indexSet in
                         
                            self.dataStore.removeBudgets(atOffsets: indexSet)
                        }
                    }
                }
            }
                .navigationTitle("Budgets")
                .navigationBarItems(trailing:
                    HStack {
                        budgets.isEmpty ? nil : EditButton()
                        Button(action: {
                            self.editViewIsPresented = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                )
                .sheet(isPresented: self.$editViewIsPresented) {
                    
                    NavigationView {
                        EditBudgetView(
                            budgetId: nil,
                            budgetViewModel: EditBudgetViewModel.empty
                        )
                    }
                }
        }
    }
}



struct BudgetsView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
        
            BudgetsView()
                .environmentObject(preview_dataStore_defaultModel as DataStore)
            
            BudgetsView()
                .environmentObject(preview_dataStore_emptyModel as DataStore)
                .previewDisplayName("Empty")
        }
    }
}
