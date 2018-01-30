import Foundation

class Resource<T> {
    
    private var callbacks: [(Result<T>) -> Void] = []
    private var cached: Result<T>?
    
    init(compute: (@escaping (Result<T>) -> Void) -> Void) {
        compute(self.then)
    }
    
    private func then(_ value: Result<T>) {
        assert(cached == nil)
        cached = value
        for callback in callbacks {
            callback(value)
        }
        callbacks = []
    }
    
    func onResult(_ callback: @escaping(Result<T>) -> Void) {
        if let value = cached {
            callback(value)
        } else {
            callbacks.append(callback)
        }
    }
    
    func map<B>(_ compute: @escaping (T) -> B) -> Resource<B> {
        return Resource<B> { completion in
            self.onResult { result in
                switch result {
                case .success(let resultValue):
                    let transformedValue = compute(resultValue)
                    completion(Result.success(transformedValue))
                case .fail(let error):
                    completion(Result.fail(error))
                }
            }
        }
    }
}

