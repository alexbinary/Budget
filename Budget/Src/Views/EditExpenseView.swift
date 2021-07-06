
import SwiftUI



struct EditExpenseView: View {

    
    struct ExpenseViewModel {
        
        init(from expense: Expense) {
            
            self.id = expense.id
            self.date = expense.date
            self.amount = "\(abs(expense.amount))"
            self.direction = expense.direction
            self.label = expense.label
        }

        var id: UUID = UUID()
        var date: Date = Date()
        var amount: String = ""
        var direction: Expense.Direction = .goingOut
        var label: String = ""
        
        var expense: Expense {
            Expense(
                id: id,
                date: date,
                amount: Double(amount)! * (direction == .goingOut ? -1 : +1),
                label: label
            )
        }
    }
    
    
    @EnvironmentObject var dataStore: DataStore
    
    @State var expenseViewModel: ExpenseViewModel
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {

        NavigationView {
        
            Form {
                DatePicker("Date", selection: $expenseViewModel.date)
                TextField("Label", text: $expenseViewModel.label)
                TextField("Amount", text: $expenseViewModel.amount)
                    .keyboardType(.numberPad)
                Picker("Direction", selection: $expenseViewModel.direction) {
                    ForEach(Expense.Direction.allCases, id: \.self) { dir in
                        Text(dir.description)
                    }
                }
            }
                .navigationTitle("Edit expense")
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            
                            self.dataStore.save(self.expenseViewModel.expense)
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

        EditExpenseView(expenseViewModel: EditExpenseView.ExpenseViewModel(from: preview_dataModel_default.expenses.first!))
    }
}
