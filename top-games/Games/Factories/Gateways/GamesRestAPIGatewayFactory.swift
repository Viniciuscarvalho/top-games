import Foundation

struct GamesRestAPIGatewayFactory {
    static func make() -> GamesGateway {
        return GamesRestAPIGateway()
    }
}
