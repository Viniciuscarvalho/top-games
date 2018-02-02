protocol Game {
    var id: Int { get }
    var coverUrl: String { get }
    var name: String { get }
    var popularity: Int { get }
    var viewers: Int { get }
    var favorite: Bool { set get }
}

struct GamesEntity: Game {
    let id: Int
    let coverUrl: String
    let name: String
    let popularity: Int
    let viewers: Int
    var favorite: Bool
}

