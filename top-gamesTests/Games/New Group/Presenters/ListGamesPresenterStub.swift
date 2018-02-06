@testable import top_games

class ListGamesPresenterStub: ListGamesPresenter {
    
    var listGamesStub = false
    var showErrorStub = false
    
    func list(games: [Game]) {
        listGamesStub = true
    }
    
    func show(error: Error?) {
        showErrorStub = true
    }
    
}
