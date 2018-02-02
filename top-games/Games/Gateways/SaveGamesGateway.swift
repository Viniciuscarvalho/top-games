protocol SaveGamesGateway {
    func save(games: [Game]) -> Resource<Void>
    func update(game: Game) -> Resource<Void>
}
