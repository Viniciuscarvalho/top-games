protocol Game {
    var id: Int { get }
    var coverUrl: String { get }
    var name: String { get }
    var pagination: String { get }
    var favorite: Bool { set get }
}

struct GamesEntity: Game {
    let id: Int
    let coverUrl: String
    let name: String
    let pagination: String
    var favorite: Bool
}

