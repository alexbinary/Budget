
import SwiftUI



struct EditBudgetView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    let budgetId: UUID?
    
    var mode: Mode { budgetId == nil ? .add : .edit }
    
    enum Mode {
        case add
        case edit
    }
    
    @State var budgetViewModel: EditBudgetViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {

        Form {
            Section {
                TextField("Name", text: $budgetViewModel.name)
            }
        }
            .navigationTitle(mode == .add ? "New budget" : budgetViewModel.name.isEmpty ? "Edit budget" : budgetViewModel.name)
            .navigationBarItems(
                leading:
                    self.mode == .add ? HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancel")
                                .fontWeight(.regular)
                        })
                } : nil,
                trailing:
                    HStack {
                        Button(action: {
                            
                            self.dataStore.save(self.budgetViewModel.budget(withId: self.budgetId))
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }, label: {
                            Text("Done")
                        })
                    }
            )
    }
}



struct EditBudgetView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
            
            NavigationView {
                
                EditBudgetView(
                    budgetId: nil,
                    budgetViewModel: EditBudgetViewModel.empty
                )
            }
            .previewDisplayName("Creation mode")
            
            NavigationView {
                
                let preview_budget = preview_budget_default
                
                EditBudgetView(
                    budgetId: preview_budget.id,
                    budgetViewModel: EditBudgetViewModel(from: preview_budget)
                )
            }
            .previewDisplayName("Edit mode")
        }
    }
}
