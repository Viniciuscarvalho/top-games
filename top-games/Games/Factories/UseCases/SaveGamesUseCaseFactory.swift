struct SaveGamesUseCaseFactory {
    
    static func make(saveGamesPresenter: SaveGamesPresenter) -> SaveGamesUseCase {
        let saveGamesGateway = SaveGamesCoreDataGatewayFactory.make()
        let gamesGateway = GamesRestAPIGatewayFactory.make()
        let cleanGamesGateway = CleanGamesCoreDataGatewayFactory.make()
        
        return SaveGamesUseCase(saveGamesGateway: saveGamesGateway, gamesGateway: gamesGateway,
                                cleanGamesGateway: cleanGamesGateway, saveGamesPresenter: saveGamesPresenter)
    }
}
