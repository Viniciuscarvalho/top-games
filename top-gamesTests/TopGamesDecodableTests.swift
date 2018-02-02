import XCTest

@testable import top_games

class TopGamesDecodableTests: XCTestCase {
    
    private var gameData: Data!
    private let firstGameId = 21779
    
    override func setUp() {
        super.setUp()
        gameData = loadJson(fromFileName: "ListGamesSuccess")
    }
    
    func testDecodeEntityFromJsonWhenAreEqualSuccess() {
        let games: TopGamesDecodable = JSONDecoder().decode(data: gameData)
        
        XCTAssertNotNil(games)
        XCTAssertEqual(games.top.count, 10)
        XCTAssertEqual(games.top.first?.game.id, firstGameId)
    }
}
