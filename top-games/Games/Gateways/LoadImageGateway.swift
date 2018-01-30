import Foundation

protocol LoadImageGateway {
    func load(url: String) -> Resource<Data>
}
