
import SwiftUI



struct ExpenseViewModel {

    var date: Date = Date()
    var amount: Double = 0.0
    var direction: Expense.Direction = .goingOut
    var label: String = ""
    
    var expense: Expense {
        Expense(
            date: date,
            amount: amount * (direction == .goingOut ? -1 : +1),
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
//                TextField("Amount", text: $expenseViewModel.amount)
//                Picker("Direction", selection: $expenseViewModel.direction) {
//                    ForEach(Expense.Direction.allCases) { dir in
//                        Text(dir)
//                    }
//                }
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



struct EditExpenseView_Previews: PreviewProvider {

    static var previews: some View {

        AddExpenseView()
    }
}
