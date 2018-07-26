struct DataDecodable: Codable {
    let id: String
    let name: String
    let box: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, box = "box_art_url"
    }
}

struct PaginationDecodable: Codable {
    let cursor: String
}

class TopGameDecodable: Codable {
    var data: [DataDecodable]
    var pagination: PaginationDecodable
}

extension DataDecodable {
    func getUrlBox(width: Int, height: Int) -> String {
        return box.replacingOccurrences(of: "{width}", with: String(width)).replacingOccurrences(of: "{height}", with: String(height))
    }
}
