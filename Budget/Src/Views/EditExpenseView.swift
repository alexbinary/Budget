
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

    
    var body: some View {

        Form {
            DatePicker("Date", selection: $expenseViewModel.date)
            TextField("Label", text: $expenseViewModel.label)
            TextField("Amount", text: $expenseViewModel.amount)
                .keyboardType(.decimalPad)
            Picker("Direction", selection: $expenseViewModel.direction) {
                ForEach(ExpenseDirection.allCases, id: \.self) { dir in
                    Text(dir.description)
                }
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
                        
                        self.dataStore.save(self.expenseViewModel.expense(withId: expenseId))
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Done")
                    })
                }
        )
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
