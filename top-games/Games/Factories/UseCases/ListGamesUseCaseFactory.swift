struct ListGamesUseCaseFactory {
    
    static func make(presenter: ListGamesPresenter) -> ListGamesUseCase {
        let gateway = GamesCoreDataGatewayFactory.make()
        return ListGamesUseCase(listGamesPresenter: presenter, gamesGateway: gateway)
    }
}
