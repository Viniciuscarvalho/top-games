import UIKit

class FavotiteGamesViewController: UIViewController {

    @IBOutlet private var listGamesView: ListGamesView! {
        didSet {
            let loadImageUseCase = LoadImageUseCaseFactory.make(presenter: listGamesView.loadImagePresenter)
            let dataProvider = GamesCollectionViewDataSource(loadImageUsecase: loadImageUseCase) { [unowned self] in
                self.didSelect(game: $0, cover: $1)
            }
            listGamesView.setup(camesCollectionViewDataSource: dataProvider)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listFavoriteGames()
    }
    
    @objc private func listFavoriteGames() {
        ListGamesUseCaseFactory.make(presenter: listGamesView.listGamesPresenter).favorites()
    }
    
    private func didSelect(game: Game, cover: UIImage?) {
        let gameDetailViewController = GameDetailViewControllerFactory.make()
        gameDetailViewController.setup(game: game, cover: cover)
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }

}
