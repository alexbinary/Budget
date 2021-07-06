
import SwiftUI



struct ExpensesView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    
    var body: some View {

        NavigationView {
            
            List {
                ForEach(dataStore.dataModel?.expenses ?? []) { expense in
                    Text(expense.title)
                }
            }
                .navigationTitle("Expenses")
        }
    }
}



struct ExpensesView_Previews: PreviewProvider {

    static var previews: some View {

        ExpensesView()
            .environmentObject(preview_dataStore as DataStore)
    }
}
