
import SwiftUI



struct BudgetsView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    
    var body: some View {

        NavigationView {
        
            Group {
            
                let categories = dataStore.dataModel?.budgets ?? []
                if categories.isEmpty {
                
                    Text("No budgets")
                    
                } else {
                    
                    List {
                        
                        ForEach(categories) { category in
                            
                            Text(category.name)
                        }
                    }
                }
            }
                .navigationTitle("Budgets")
                .navigationBarItems(trailing:
                    HStack {
                        
                    }
                )
        }
    }
}



struct BudgetsView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
        
            BudgetsView()
                .environmentObject(preview_dataStore_defaultModel as DataStore)
            
            BudgetsView()
                .environmentObject(preview_dataStore_emptyModel as DataStore)
                .previewDisplayName("Empty")
        }
    }
}
