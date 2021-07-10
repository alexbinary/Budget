
import SwiftUI



struct CategoriesView: View {

    
    @EnvironmentObject var dataStore: DataStore
    
    
    var body: some View {

        NavigationView {
        
            Group {
            
                let categories = dataStore.dataModel?.categories ?? []
                if categories.isEmpty {
                
                    Text("No categories")
                    
                } else {
                    
                    List {
                        
                        ForEach(categories) { category in
                            
                            Text(category.name)
                        }
                    }
                }
            }
                .navigationTitle("Categories")
        }
    }
}



struct CategoriesView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
        
            CategoriesView()
                .environmentObject(preview_dataStore_defaultModel as DataStore)
            
            CategoriesView()
                .environmentObject(preview_dataStore_emptyModel as DataStore)
                .previewDisplayName("Empty")
        }
    }
}
