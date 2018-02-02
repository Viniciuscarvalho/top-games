import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameBackgroundView: UIView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCornerRadius()
        setupBackground()
    }
    
    private func setupCornerRadius() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    
    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = nameBackgroundView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        nameBackgroundView.layer.insertSublayer(gradient, at: 0)
        coverImageView.transform = coverImageView.transform.rotated(by: -CGFloat(Double.pi / 6))
    }
    
    func setup(game: Game, row: Int) {
        nameLabel.text = "#\(row) \(game.name.uppercased())"
        var image = UIImage(named: "star")
        if game.favorite {
            image = UIImage(named: "star_filled")
        }
        favoriteImageView.image = image
    }
    
    func setup(cover: UIImage?) {
        coverImageView.image = cover
    }
}
