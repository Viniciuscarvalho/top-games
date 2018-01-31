struct LoadImageUseCaseFactory {
    static func make(presenter: LoadImagePresenter) -> LoadImageUseCase {
        return LoadImageUseCase(imageCacheGateway: ImageCacheDictionaryGatewayFactory.make(),
                                loadImagePresenter: presenter,
                                loadImageGateway: LoadImageRestAPIGatewayFactory.make())
    }
}
