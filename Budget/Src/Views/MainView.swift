
import SwiftUI



struct MainView: View {

    var body: some View {

        TabView {
        
            ExpensesView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Expenses")
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        MainView()
    }
}
