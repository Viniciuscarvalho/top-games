import Foundation
@testable import top_games

class GamesGatewayStub: GamesGateway {
    
    var gamesStub = false
    var favoritesStub = false
    var gamesOnCompleteStub: Result<[Game]>!
    var favoritesOnCompleteStub: Result<[Game]>!
    
    func allGames() -> Resource<[Game]> {
        gamesStub = true
        return Resource { completion in
            completion(gamesOnCompleteStub)
        }
    }
    
    func allFavoriteGames() -> Resource<[Game]> {
        favoritesStub = true
        return Resource { completion in
            completion(favoritesOnCompleteStub)
        }
    }
}
