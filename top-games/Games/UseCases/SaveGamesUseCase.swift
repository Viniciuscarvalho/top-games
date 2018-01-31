struct SaveGamesUseCase {
    
    private let saveGamesGateway: SaveGamesGateway
    private let gamesGateway: GamesGateway
    private let cleanGamesGateway: CleanGamesGateway
    private let saveGamesPresenter: SaveGamesPresenter
    
    init(saveGamesGateway: SaveGamesGateway, gamesGateway: GamesGateway, cleanGamesGateway: CleanGamesGateway, saveGamesPresenter: SaveGamesPresenter) {
        self.saveGamesGateway = saveGamesGateway
        self.gamesGateway = gamesGateway
        self.cleanGamesGateway = cleanGamesGateway
        self.saveGamesPresenter = saveGamesPresenter
    }
    
    func save() {
        gamesGateway.allGames().map({
            _ = self.cleanGamesGateway.clean()
            return $0
        })
            .flatMap(saveGamesGateway.save).onResult({ result in
                switch result {
                case .success:
                    self.saveGamesPresenter.saved()
                case .fail(let error):
                    self.saveGamesPresenter.show(error: error)
                }
            })
    }
}
