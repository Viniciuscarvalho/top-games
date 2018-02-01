import CoreData

struct GamesCoreDataGateway: GamesGateway {
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func allGames() -> Resource<[Game]> {
        return Resource { completion in
            do {
                let fetchGames: NSFetchRequest<GameEntityCoreData> = GameEntityCoreData.fetchRequest()
                let games = try managedObjectContext.fetch(fetchGames)
                let gamesEntities = games.map(generateEntity)
                completion(Result.success(gamesEntities))
            } catch {
                completion(Result.fail(error))
            }
        }
    }
    
    private func generateEntity(game: GameEntityCoreData) -> Game {
        return GamesEntity(id: game.id.int,
                          coverUrl: game.coverUrl ?? String.empty,
                          name: game.name ?? String.empty,
                          popularity: game.popularity.int,
                          viewers: game.viewers.int)
    }
}
