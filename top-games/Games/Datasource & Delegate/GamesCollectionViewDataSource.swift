import UIKit

class GamesCollectionViewDataSource: NSObject, UISearchBarDelegate {
    
    private var games: [Game] = []
    private var gamesCovers: [String: UIImage?] = [:]
    private let loadImageUsecase: LoadImageUseCase
    private var didSelectGame: ((Game, UIImage?) -> Void)
    
    init(loadImageUsecase: LoadImageUseCase, didSelectGame: @escaping ((Game, UIImage?) -> Void)) {
        self.loadImageUsecase = loadImageUsecase
        self.didSelectGame = didSelectGame
    }
    
    func update(with games: [Game]) {
        self.games = games
    }
    
    func updateGameCover(id: String, image: UIImage?) {
        self.gamesCovers[id] = image
    }

    private func game(atRow row: Int) -> Game {
        return games[row]
    }
    
    private func gameCover(byId id: String) -> UIImage? {
        guard let cover = gamesCovers[id] else { return nil }
        return cover
    }
    
    private func hasCover(forId id: String) -> Bool {
        return gamesCovers.keys.contains(id)
    }
}

extension GamesCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.Identifier.gamesCollection, for: indexPath)
        
        if let gameCell = cell as? GameCollectionViewCell {
            let game = self.game(atRow: indexPath.row)
            if hasCover(forId: game.id) {
                gameCell.setup(cover: gameCover(byId: game.id))
            } else {
                loadImageUsecase.load(id: game.id, url: game.coverUrl)
            }
            gameCell.setup(game: game, row: indexPath.row+1)
        }
        
        return cell
    }
    
}

extension GamesCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 25
        let collectionCellSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = self.game(atRow: indexPath.row)
        didSelectGame(game, gameCover(byId: game.id))
    }
}

