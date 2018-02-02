import UIKit

extension Notification.Name {
    struct Game {
        static let didSaveGames = Notification.Name(rawValue: "topgames.notification.name.game.didSaveGames")
        static let didFavoriteGame = Notification.Name(rawValue: "topgames.notification.name.game.didFavoriteGame")
        static let didUnfavoriteGame = Notification.Name(rawValue: "topgames.notification.name.game.didUnfavoriteGame")
    }
}

extension Notification {
    struct Game {
        static let didSaveGames = Notification(name: Notification .Name.Game.didSaveGames)
        static let didFavoriteGame = Notification(name: Notification .Name.Game.didFavoriteGame)
        static let didUnfavoriteGame = Notification(name: Notification .Name.Game.didUnfavoriteGame)
    }
}
