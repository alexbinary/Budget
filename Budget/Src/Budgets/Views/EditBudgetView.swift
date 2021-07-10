
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
    
    @State var invalidAmountAlertIsPresented = false
    
    
    var body: some View {

        Form {
            Section {
                TextField("Name", text: $budgetViewModel.name)
            }
            Section {
                TextField("Amount", text: $budgetViewModel.amount)
                    .keyboardType(.decimalPad)
                    .font(.custom("", size: 42))
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
                            
                            do {
                                self.dataStore.save(try self.budgetViewModel.budget(withId: self.budgetId))
                                self.presentationMode.wrappedValue.dismiss()
                            } catch {
                                self.invalidAmountAlertIsPresented = true
                            }
                            
                        }, label: {
                            Text("Done")
                        })
                    }
            )
            .alert(isPresented: $invalidAmountAlertIsPresented) {
                Alert(title: Text("Invalid amount"))
            }
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
