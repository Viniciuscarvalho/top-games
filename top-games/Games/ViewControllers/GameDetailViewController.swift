import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet private weak var gameDetailView: GameDetailView! {
        didSet {
            gameDetailView.setup(game: game, image: cover)
        }
    }
    
    private var game: Game!
    private var cover: UIImage!
    
    func setup(game: Game, cover: UIImage?) {
        self.game = game
        self.cover = cover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = game.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var image = UIImage(named: "star")
        if game.favorite {
            image = UIImage(named: "star_filled")
        }
        
        let favoriteButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toggleFavorite))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = favoriteButton
    }
    
    @objc func toggleFavorite(_ sender: UIBarButtonItem) {
        let core = SaveGamesCoreDataGateway(managedObjectContext: ManagedObjectContextFactory.make())
        
        //game.favorite = !game.favorite
        
        core.update(game: game).onResult { result in
            switch result {
            case .success(_):
                if self.game.favorite {
                    sender.image = UIImage(named: "star_filled")
                    NotificationCenter.default.post(Notification.Game.didFavoriteGame)
                } else {
                    sender.image = UIImage(named: "star")
                    NotificationCenter.default.post(Notification.Game.didUnfavoriteGame)
                }
                break
            case .fail(let error):
                print(error ?? "👻")
                break
            }
        }
    }
}
