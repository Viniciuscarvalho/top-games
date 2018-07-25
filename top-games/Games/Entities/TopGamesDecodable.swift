struct TopGameDecodable: Decodable {
    let data: [DataDecodable]
    let pagination: String
}

extension TopGameDecodable {
    struct DataDecodable: Decodable {
        let id: String
        let name: String
        let box: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, box = "box_art_url"
        }
    }
}

extension TopGameDecodable.DataDecodable {
    func getUrlBox(width: Int, height: Int) -> String {
        return box.replacingOccurrences(of: "{width}", with: String(width)).replacingOccurrences(of: "{height}", with: String(height))
    }
}

extension TopGameDecodable {
    struct PaginationDecodable: Decodable {
        let cursor: String
    }
}
