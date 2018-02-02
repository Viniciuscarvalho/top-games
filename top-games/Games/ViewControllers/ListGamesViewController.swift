import UIKit

class ListGamesViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(listGames), for: .valueChanged)
        return refreshControl
    }()
    
    private var searchUseCase: SearchGamesUseCase!
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveGames()
        
        searchUseCase = SearchGamesUseCase(listGamesPresenter: listGamesView,
                                           gamesGateway: GamesCoreDataGatewayFactory.make())
        
        definesPresentationContext = true
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didSaveGames, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didFavoriteGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(listGames), name: NSNotification.Name.Game.didUnfavoriteGame, object: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listGames()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        searchUseCase.search(term: text)
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

extension ListGamesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchUseCase.search(term: text)
    }
}


