struct TopGamesDecodable: Decodable {
    let top: [TopGameDecodable]
}

extension TopGamesDecodable {
    struct TopGameDecodable: Decodable {
        let game: GameDecodable
        let viewers: Int
    }
}

extension TopGamesDecodable.TopGameDecodable {
    struct GameDecodable: Decodable {
        let name: String
        let popularity: Int
        let id: Int
        let box: BoxDecodable
        
        enum CodingKeys: String, CodingKey {
            case id = "_id", popularity, name, box
        }
    }
}

extension TopGamesDecodable.TopGameDecodable.GameDecodable {
    struct BoxDecodable: Decodable {
        let large: String
    }
}
