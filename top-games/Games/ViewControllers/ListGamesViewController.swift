import UIKit

class ListGamesViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet private var listGamesView: ListGamesView! {
        didSet {
            let loadImageUseCase = LoadImageUseCaseFactory.make(presenter: listGamesView.loadImagePresenter)
            let dataProvider = GamesCollectionViewDataSource(loadImageUsecase: loadImageUseCase) { [unowned self] in
                self.didSelect(game: $0, cover: $1)
            }
            listGamesView.setup(camesCollectionViewDataSource: dataProvider)
            listGamesView.setup(refreshControl: refreshControl)
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(saveGames), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveGames()
        setupSearch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didSaveGames, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didFavoriteGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didUnfavoriteGame, object: nil)
    }
    
    func setupSearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc private func saveGames() {
        SaveGamesUseCaseFactory.make(saveGamesPresenter: listGamesView.saveGamesPresenter).save()
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didSaveGames, object: nil)
    }
    
    @objc private func listGames() {
        ListGamesUseCaseFactory.make(presenter: listGamesView.listGamesPresenter).list()
        refreshControl.endRefreshing()
    }
    
    private func didSelect(game: Game, cover: UIImage?) {
        let gameDetailViewController = GameDetailViewControllerFactory.make()
            gameDetailViewController.setup(game: game, cover: cover)
            navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
}

