protocol GamesGateway {
    func allGames() -> Resource<[Game]>
    func allFavoriteGames() -> Resource<[Game]>
}
