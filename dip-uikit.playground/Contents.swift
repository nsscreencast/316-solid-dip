import Foundation
import UIKit
import CoreData

struct Todo {
    let text: String
}

protocol TodoStorage {
    func save(todo: Todo)
    func getTodos() -> [Todo]
}

class TodoManager : TodoStorage {
    private let context: NSManagedObjectContext
    
    static var shared: TodoManager!
    
    static func initialize(with context: NSManagedObjectContext) {
        shared = TodoManager(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getTodos() -> [Todo] {
        return []
    }
    
    func save(todo: Todo) {
        //
    }
}

class TodoViewController : UIViewController {
    
    var todoStorage: TodoStorage!
    
    func save() {
        let todo = Todo(text: "Get Milk")
        todoStorage.save(todo: todo)
    }
}

let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
TodoManager.initialize(with: context)

let todoVC = TodoViewController()
todoVC.todoStorage = TodoManager(context: context)
todoVC.save()
