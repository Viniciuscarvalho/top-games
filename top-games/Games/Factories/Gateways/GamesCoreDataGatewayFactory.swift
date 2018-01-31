import UIKit

struct GamesCoreDataGatewayFactory {
    static func make() -> GamesGateway {
        return GamesCoreDataGateway(managedObjectContext: ManagedObjectContextFactory.make())
    }
}
