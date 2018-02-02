import XCTest

extension XCTestCase {
    
    func loadJson(fromFileName fileName: String) -> Data {
        let bundle = Bundle(for: TopGamesDecodableTests.self)
        let filePath = bundle.path(forResource: fileName, ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
    }
    
}
