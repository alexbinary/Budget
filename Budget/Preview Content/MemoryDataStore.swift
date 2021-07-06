
import Foundation



class MemoryDataStore: DataStore {
    
    
    init(withModel dataModel: DataModel?) {
        
        super.init()
        self.dataModel = dataModel
    }
    
    
    override func loadDataModelFromStorage() -> DataModel? {
        
        return nil
    }
    
    
    override func persistDataModelToStorage() {
        
    }
}
