protocol ListGamesPresenter {
    func list(games: [Game])
    func show(error: Error?)
}
