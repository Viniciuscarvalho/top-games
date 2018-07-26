import Foundation

protocol ImageCacheGateway {
    func existCache(forKey key: String) -> Bool
    func cache(key: String, value: Data)
    func value(forKey key: String) throws -> Data
}
