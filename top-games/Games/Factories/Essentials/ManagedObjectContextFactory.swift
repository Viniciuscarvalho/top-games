import UIKit
import CoreData

struct ManagedObjectContextFactory {
    static func make() -> NSManagedObjectContext {
        let application = UIApplication.shared.delegate as! AppDelegate
        return application.coreDataStack.persistentContainer.viewContext
    }
}
