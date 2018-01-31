protocol SaveGamesGateway {
    func save(games: [Game]) -> Resource<Void>
}
