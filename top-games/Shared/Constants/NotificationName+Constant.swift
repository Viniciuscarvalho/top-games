import UIKit

extension Notification.Name {
    struct Game {
        static let didSaveGames = Notification.Name(rawValue: "topgames.notification.name.game.didSaveGames")
    }
}

extension Notification {
    struct Game {
        static let didSaveGames = Notification(name: Notification .Name.Game.didSaveGames)
    }
}
