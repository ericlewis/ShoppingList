import CoreData

class ListManager: ObservableObject {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func toggleComplete(_ item: Item) -> () -> Void {
        func toggleComplete() {
            context.perform {
                item.objectWillChange.send()
                item.isComplete.toggle()
                try? self.context.save()
            }
        }
        
        return toggleComplete
    }
    
    func add(_ title: String, count: Int, notes: String? = nil) {
        context.perform {
            let item = Item(context: self.context)
            item.title = title
            item.order = Int32(count)
            item.notes = notes
            try? self.context.save()
        }
    }
}
