
import SwiftUI



struct EditExpenseView: View {
    
    
    @EnvironmentObject var dataStore: DataStore
    
    let expenseId: UUID?
    
    var mode: Mode { expenseId == nil ? .add : .edit }
    
    enum Mode {
        case add
        case edit
    }
    
    @State var expenseViewModel: EditExpenseViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var invalidAmountAlertIsPresented = false

    
    var body: some View {

        Form {
            Section {
                TextField("Amount", text: $expenseViewModel.amount)
                    .keyboardType(.decimalPad)
                    .font(.custom("", size: 42))
                Picker("Direction", selection: $expenseViewModel.direction) {
                    ForEach(ExpenseDirection.allCases, id: \.self) { dir in
                        Text(dir.description)
                    }
                }
            }
            Section {
                TextField("Label", text: $expenseViewModel.label)
                DatePicker("Date", selection: $expenseViewModel.date)
            }
        }
        .navigationTitle(mode == .add ? "New expense" : expenseViewModel.label.isEmpty ? "Edit expense" : expenseViewModel.label)
        .navigationBarItems(
            leading:
                mode == .add ? HStack {
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
                            self.dataStore.save(try self.expenseViewModel.expense(withId: expenseId))
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



struct EditExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
        
            NavigationView {
                
                EditExpenseView(
                    expenseId: nil,
                    expenseViewModel: EditExpenseViewModel.empty
                )
            }
            .previewDisplayName("Creation mode")
            
            NavigationView {
                
                let preview_expense = preview_dataModel_default.expenses.first!
                
                EditExpenseView(
                    expenseId: preview_expense.id,
                    expenseViewModel: EditExpenseViewModel(from: preview_expense)
                )
            }
            .previewDisplayName("Edit mode")
        }
    }
}
