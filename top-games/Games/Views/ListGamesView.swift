import UIKit

class ListGamesView: NibLoadableView {
    
    @IBOutlet private weak var loadingView: LoadingView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: String(describing: GameCollectionViewCell.self), bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: String.Identifier.gamesCollection)
        }
    }
    
    private var camesCollectionViewDataSource: GamesCollectionViewDataSource! {
        didSet {
            collectionView.dataSource = camesCollectionViewDataSource
            collectionView.delegate = camesCollectionViewDataSource
        }
    }
    
    var listGamesPresenter: ListGamesPresenter { return self }
    var saveGamesPresenter: SaveGamesPresenter { return self }
    var loadImagePresenter: LoadImagePresenter { return self }
    
    func setup(refreshControl: UIRefreshControl) {
        collectionView.addSubview(refreshControl)
    }
    
    func setup(camesCollectionViewDataSource: GamesCollectionViewDataSource) {
        self.camesCollectionViewDataSource = camesCollectionViewDataSource
    }
    
    func show(error: Error?) {
        loadingView.stopLoading()
        guard let error = error else { return }
        print(error)
    }
}

extension ListGamesView: ListGamesPresenter {
    
    func list(games: [Game]) {
        camesCollectionViewDataSource.update(with: games)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.loadingView.stopLoading()
        }
    }

}

extension ListGamesView: SaveGamesPresenter {
    
    func saved() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(Notification.Game.didSaveGames)
        }
    }
}

extension ListGamesView: LoadImagePresenter {
    
    func show(data: Data, forId id: Int) {
        let image = UIImage(data: data)
        camesCollectionViewDataSource.updateGameCover(id: id, image: image)
        if let row = camesCollectionViewDataSource.row(ofId: id) {
            let intedPathToUpdate = IndexPath(row: row, section: 0)
            DispatchQueue.main.async { [unowned self] in
                self.collectionView.reloadItems(at: [intedPathToUpdate])
            }
        }
    }
}
