import Foundation

protocol LoadImagePresenter {
    func show(data: Data, forId id: String)
    func show(error: Error?)
}
