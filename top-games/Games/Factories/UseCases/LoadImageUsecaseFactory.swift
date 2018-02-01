struct LoadImageUseCaseFactory {
    static func make(presenter: LoadImagePresenter) -> LoadImageUseCase {
        return LoadImageUseCase(imageCacheGateway: ImageCacheDictionaryGatewayFactory.make(),
                                loadImageGateway: LoadImageRestAPIGatewayFactory.make(), loadImagePresenter: presenter)
    }
}
