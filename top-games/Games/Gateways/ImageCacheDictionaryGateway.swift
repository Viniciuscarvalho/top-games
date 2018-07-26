import Foundation

class ImageCacheDictionaryGateway: ImageCacheGateway {
    
    private var cachedImages: [String: Data] = [:]
    
    func cache(key: String, value: Data) {
        cachedImages[key] = value
    }
    
    func existCache(forKey key: String) -> Bool {
        return cachedImages.keys.contains(key)
    }
    
    func value(forKey key: String) throws -> Data {
        guard let data = cachedImages[key] else { throw ImageCacheError.notFound }
        return data
    }
    
}

