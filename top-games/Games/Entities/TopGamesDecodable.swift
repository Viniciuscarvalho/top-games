struct TopGamesDecodable: Decodable {
    let data: [TopGameDecodable]
}

extension TopGamesDecodable {
    struct TopGameDecodable: Decodable {
        let data: DataDecodable
        let pagination: String
    }
}

extension TopGamesDecodable.TopGameDecodable {
    struct DataDecodable: Decodable {
        let name: String
        let id: Int
        let box: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, box = "box_art_url"
        }
    }
}

extension TopGamesDecodable.TopGameDecodable {
    struct PaginationDecodable: Decodable {
        let cursor: String
    }
}
