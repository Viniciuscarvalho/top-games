struct SearchGamesUseCase {
    
    private let listGamesPresenter: ListGamesPresenter
    private let gamesGateway: GamesGateway
    
    init(listGamesPresenter: ListGamesPresenter, gamesGateway: GamesGateway) {
        self.listGamesPresenter = listGamesPresenter
        self.gamesGateway = gamesGateway
    }
    
    func search(term: String) {
        gamesGateway.allGames().onResult { result in
            switch result {
            case .success(let games):
                var newGames: [Game]!
                if term.isEmpty {
                    newGames = games
                } else {
                    newGames = games.filter({ $0.name == term })
                }
                
                if newGames.count > 0 {
                    self.listGamesPresenter.list(games: newGames)
                } else {
                    //TODO: Colocar empty state
                }
            case .fail(let error): self.listGamesPresenter.show(error: error)
            }
        }
    }
}
