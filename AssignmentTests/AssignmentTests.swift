import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testSizeReturnsTheCorrectValueOfHeight() {
        let inputString = "This is a Test String."
        
        let size = inputString.size(font: UIFont.systemFont(ofSize: 17), maxSize: CGSize(width: 375, height: 10000))
        
        let expectedHeight: CGFloat = 20.287109375
        XCTAssertEqual(size.height, expectedHeight)
    }
    
    func testUrlRequestReturnsTheCorrectHttpMethod() {
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let urlRequest = url.urlRequest()
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(urlRequest.httpMethod, expectedHttpMethod)
    }
}
