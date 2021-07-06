
import SwiftUI



struct ExpenseViewModel {

    var date: Date = Date()
    var amount: String = ""
    var direction: Expense.Direction = .goingOut
    var label: String = ""
    
    var expense: Expense {
        Expense(
            date: date,
            amount: Double(amount)! * (direction == .goingOut ? -1 : +1),
            label: label
        )
    }
}



struct AddExpenseView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    @State var expenseViewModel: ExpenseViewModel = ExpenseViewModel()
    
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
                .navigationTitle("Add expense")
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



struct AddExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        AddExpenseView()
    }
}
