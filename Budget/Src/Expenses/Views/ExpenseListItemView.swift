
import SwiftUI



struct ExpenseListItemView: View {

    
    @State var expense: Expense
    
    
    private func format(_ date: Date) -> String {
       
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
    
    
    var body: some View {

        let expenseViewModel = ShowExpenseViewModel(from: expense)
        
        HStack {
            VStack(alignment: .leading) {
                Text(format(expenseViewModel.date))
                    .font(.callout)
                Text(expenseViewModel.label.isEmpty ? "no description" : expenseViewModel.label)
                    .font(.caption)
                    .italic(expenseViewModel.label.isEmpty)
                    .foregroundColor(expenseViewModel.label.isEmpty ? .secondary : .primary)
            }
            Spacer()
            Text(Formatter.format(currency: expenseViewModel.amount))
                .font(.headline)
                .foregroundColor(expenseViewModel.isGoingOut ? .red : .green)
        }
    }
}



struct ExpenseListItemView_Previews: PreviewProvider {

    static var previews: some View {

        ExpenseListItemView(expense: preview_dataModel_default.expenses.first!)
    }
}
