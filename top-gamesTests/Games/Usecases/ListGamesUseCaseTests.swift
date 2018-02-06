import XCTest

@testable import top_games

class ListGamesUseCaseTests: XCTestCase {
    
    private var usecase: ListGamesUseCase!
    private var gateway: GamesGatewayStub!
    private var presenter: ListGamesPresenterStub!
    
    override func setUp() {
        super.setUp()
        gateway = GamesGatewayStub()
        presenter = ListGamesPresenterStub()
        usecase = ListGamesUseCase(listGamesPresenter: presenter, gamesGateway: gateway)
    }
    
    func testListGamesWhenCompleteRequestWithSuccessThenListGames() {
        gateway.gamesOnCompleteStub = Result.success([])
        usecase.list()
        
        XCTAssertTrue(gateway.gamesStub)
        XCTAssertTrue(presenter.listGamesStub)
    }
    
    func testListFavoriteGamesWhenCompleteRequestWithSuccessThenListFavoriteGames() {
        gateway.favoritesOnCompleteStub = Result.success([])
        
        usecase.favorites()
        
        XCTAssertTrue(gateway.favoritesStub)
        XCTAssertTrue(presenter.listGamesStub)
    }
    
    func testListGamesWhenCompleteRequestWithFailThenPresentError() {
        gateway.gamesOnCompleteStub = Result.fail(TopGamesError.invalidRequest)
        
        usecase.list()
        
        XCTAssertTrue(gateway.gamesStub)
        XCTAssertTrue(presenter.showErrorStub)
    }
    
    func testListFavoriteGamesWhenCompleteRequestWithFailThenPresentError() {
        gateway.favoritesOnCompleteStub = Result.fail(TopGamesError.invalidRequest)
        
        usecase.favorites()
        
        XCTAssertTrue(gateway.favoritesStub)
        XCTAssertTrue(presenter.showErrorStub)
    }
    
}
