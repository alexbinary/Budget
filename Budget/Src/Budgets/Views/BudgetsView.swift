
import SwiftUI



struct BudgetsView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    @State var editViewIsPresented: Bool = false
    
    
    var body: some View {

        NavigationView {
        
            Group {
            
                let budgets = dataStore.dataModel?.budgets ?? []
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
                                    Text(budget.name)
                                }
                            )
                        }
                        .onDelete { indexSet in
                         
                            self.dataStore.removeBudget(atOffsets: indexSet)
                        }
                    }
                }
            }
                .navigationTitle("Budgets")
                .navigationBarItems(trailing:
                    HStack {
                        EditButton()
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
