import UIKit
import Foundation

class GamesRouterNavigation: GamesRouter {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func root() {
        
    }
    
    func gamesDetail(game: Game) {
    
    }
}
