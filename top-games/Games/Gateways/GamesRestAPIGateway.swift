import Foundation

struct GamesRestAPIGateway: GamesGateway {
    
    func allGames() -> Resource<[Game]> {
        var request = URLRequest(url: URL.Twitch.topGame)
        request.httpMethod = String.HttpMethod.get
        request.addValue(String.Twitch.Header.clientId, forHTTPHeaderField: String.clientId)
        request.addValue(String.Twitch.Header.accept, forHTTPHeaderField: String.accept)
        
        return Resource { completion in
            URLSession.shared.dataTask(with: request,
                                       completionHandler: { (data: Data?, _, error: Error?) -> Void in
                                        completion(self.generateResult(data: data, error: error))}).resume()
            URLSession.shared.finishTasksAndInvalidate()
        }
    }
    
    private func generateResult(data: Data?, error: Error?) -> Result<[Game]> {
        
        if error == nil, let data = data {
            var topGames: TopGamesDecodable
            do {
                topGames = try JSONDecoder().decode(TopGamesDecodable.self, from: data)
            } catch let error { return Result.fail(error) }
            
            let games = generateGameEntity(topGames: topGames)
            return Result.success(games)
        } else if data == nil {
            return Result.fail((TopGamesError.noResponse as! Error))
        }
        
        return Result.fail(error)
        
    }
    
    private func generateGameEntity(topGames: TopGamesDecodable) -> [Game] {
        let games = topGames.top.map { topGame -> Game in
            return GamesEntity(id: topGame.game.id,
                               coverUrl: topGame.game.box.large,
                               name: topGame.game.name,
                               popularity: topGame.game.popularity,
                               viewers: topGame.viewers,
                               favorite: false)
        }
        return games
    }
}

