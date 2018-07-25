import CoreData

struct SaveGamesCoreDataGateway: SaveGamesGateway {
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func save(games: [Game]) -> Resource<Void> {
        return Resource { completion in
            let entityName = String(describing: GameEntityCoreData.self)
            for game in games {
                var gameCoreData: GameEntityCoreData?
                gameCoreData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: self.managedObjectContext) as? GameEntityCoreData
                gameCoreData?.id = Int32(game.id)
                gameCoreData?.coverUrl = game.coverUrl
                gameCoreData?.name = game.name
                gameCoreData?.favorite = game.favorite
            }
            completion(self.generateResult())
        }
    }
    
    func update(game: Game) -> Resource<Void> {
        return Resource { completion in
            let entityName = String(describing: GameEntityCoreData.self)
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", game.name)
            fetchRequest.predicate = predicate
            
            do {
                let result = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
                if result.count > 0 {
                    let gameCoreData = result.first as? GameEntityCoreData
                    gameCoreData?.favorite = game.favorite
                }
            } catch {
                print(error)
            }
            completion(self.generateResult())
        }
    }
    
    private func generateResult() -> Result<Void> {
        do {
            try managedObjectContext.save()
            return Result.success(())
        } catch {
            return Result.fail(error)
        }
    }
}
