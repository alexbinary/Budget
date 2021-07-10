
import Foundation



class DataStore: ObservableObject {
    
    
    @Published var dataModel: DataModel? = nil
    
    
    func loadDataModelFromStorage() -> DataModel? {
        
        return nil
    }
    
    
    func persistDataModelToStorage() {
        
    }
    
    
    public func save(_ expense: Expense) {
        
        if let idx = self.dataModel!.expenses.firstIndex(where: { $0.id == expense.id }) {
            
            self.dataModel!.expenses[idx] = expense
            
        } else {
            
            self.dataModel!.expenses.append(expense)
        }
        
        self.persistDataModelToStorage()
    }
    
    
    public func removeExpenses(atOffsets offsets: IndexSet) {
        
        self.dataModel!.expenses.remove(atOffsets: offsets)
        self.persistDataModelToStorage()
    }
    
    
    public func save(_ budget: Budget) {
        
        if let idx = self.dataModel!.budgets.firstIndex(where: { $0.id == budget.id }) {
            
            self.dataModel!.budgets[idx] = budget
            
        } else {
            
            self.dataModel!.budgets.append(budget)
        }
        
        self.persistDataModelToStorage()
    }
    
    
    public func removeBudgets(atOffsets offsets: IndexSet) {
        
        self.dataModel!.budgets.remove(atOffsets: offsets)
        self.persistDataModelToStorage()
    }
}



class FileDataStore: DataStore {
    

    private let fileName: String
    
    
    init(withFileName fileName: String) {
        
        self.fileName = fileName
        super.init()
        self.dataModel = self.loadDataModelFromStorage() ?? DataModel()
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
