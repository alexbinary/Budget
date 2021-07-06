
import Foundation



class DataStore: ObservableObject {
    
    
    @Published var dataModel: DataModel? = nil
    
    
    func loadDataModelFromStorage() -> DataModel? {
        
        return nil
    }
    
    
    func persistDataModelToStorage() {
        
    }
}



class FileDataStore: DataStore {
    

    private let fileName: String
    
    
    init(withFileName fileName: String) {
        
        self.fileName = fileName
        super.init()
        self.dataModel = self.loadDataModelFromStorage()
    }
    
    
    override func loadDataModelFromStorage() -> DataModel? {
        
        return Self.readDataModel(fromFileWithName: self.fileName)
    }
    
    
    override func persistDataModelToStorage() {
        
        guard self.dataModel != nil else { return }
        Self.write(self.dataModel!, toFileWithName: self.fileName)
    }
    
    
    static func readDataModel(fromFileWithName fileName: String) -> DataModel? {
        
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode(DataModel.self, from: data)
    }
    
    
    static func write(_ dataModel: DataModel, toFileWithName fileName: String) {
        
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        let data = try! JSONEncoder().encode(dataModel)
        try! data.write(to: fileURL)
    }
}
