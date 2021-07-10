
import SwiftUI



struct MainView: View {

    var body: some View {

        TabView {
        
            ExpensesView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Expenses")
                }
            
            BudgetsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Budgets")
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        MainView()
    }
}
