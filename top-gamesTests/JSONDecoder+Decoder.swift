import Foundation

extension JSONDecoder {
    
    func decode<T: Decodable>(data: Data) -> T {
        return try! self.decode(T.self, from: data)
    }
    
}
