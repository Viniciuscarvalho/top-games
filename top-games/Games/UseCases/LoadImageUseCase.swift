import Foundation

struct LoadImageUseCase {
    
    private let imageCacheGateway: ImageCacheGateway
    private let loadImageGateway: LoadImageGateway
    private let loadImagePresenter: LoadImagePresenter
    
    init(imageCacheGateway: ImageCacheGateway, loadImageGateway: LoadImageGateway, loadImagePresenter: LoadImagePresenter) {
        self.imageCacheGateway = imageCacheGateway
        self.loadImageGateway = loadImageGateway
        self.loadImagePresenter = loadImagePresenter
    }
    
    func load(id: String, url: String) {
        if imageCacheGateway.existCache(forKey: id) {
            do {
                let data = try imageCacheGateway.value(forKey: id)
                loadImagePresenter.show(data: data, forId: id)
            } catch {
                loadImagePresenter.show(error: error)
            }
        } else {
            loadImageGateway.load(url: url).onResult({ result in
                switch result {
                case .success(let data):
                    self.imageCacheGateway.cache(key: id, value: data)
                    self.loadImagePresenter.show(data: data, forId: id)
                case .fail(let error):
                    self.loadImagePresenter.show(error: error)
                }
            })
        }
    }
}
