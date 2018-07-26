import Foundation
import CoreData

extension GameEntityCoreData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntityCoreData> {
        return NSFetchRequest<GameEntityCoreData>(entityName: "GameEntityCoreData")
    }
    
    @NSManaged public var coverUrl: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var favorite: Bool
}
