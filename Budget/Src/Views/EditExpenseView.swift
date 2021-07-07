
import SwiftUI



struct EditExpenseView: View {
    
    
    @EnvironmentObject var dataStore: DataStore
    
    let expenseId: UUID?
    
    @State var expenseViewModel: EditExpenseViewModel
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {

        NavigationView {
        
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
                .navigationTitle("Edit expense")
                .navigationBarItems(trailing:
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
}



struct EditExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        let preview_expense = preview_dataModel_default.expenses.first!
        EditExpenseView(
            expenseId: preview_expense.id,
            expenseViewModel: EditExpenseViewModel(from: preview_expense)
        )
    }
}
