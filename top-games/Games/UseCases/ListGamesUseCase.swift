struct ListGamesUseCase {
    
    private let listGamesPresenter: ListGamesPresenter
    private let gamesGateway: GamesGateway
    
    init(listGamesPresenter: ListGamesPresenter, gamesGateway: GamesGateway) {
        self.listGamesPresenter = listGamesPresenter
        self.gamesGateway = gamesGateway
    }
    
    func list() {
        gamesGateway.allGames().onResult { result in
            switch result {
            case .success(let games): self.listGamesPresenter.list(games: games)
            case .fail(let error): self.listGamesPresenter.show(error: error)
            }
        }
    }
    
    func favorites() {
        gamesGateway.allFavoriteGames().onResult { result in
            switch result {
            case .success(let games): self.listGamesPresenter.list(games: games)
            case .fail(let error): self.listGamesPresenter.show(error: error)
            }
        }
    }
}
