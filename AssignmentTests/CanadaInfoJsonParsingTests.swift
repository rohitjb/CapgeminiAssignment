import XCTest
@testable import Assignment

class CanadaInfoJsonParsingTests: XCTestCase {
    let decoder = JSONDecoder()
    var canadaInfo: CanadaInfo!
    
    override func setUp() {
        super.setUp()
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "CanadaInfo", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        canadaInfo = try! decoder.decode(CanadaInfo.self, from: data!)
    }
    
    
    func testCanadaInfoReturnsCorrectTitle() {
        let expectedTitle = "About Canada"
        
        XCTAssertEqual(canadaInfo.title, expectedTitle)
    }
    
    func testCanadaInfoReturnsCorrectNumberOfRows() {
        let expectedRows = 14
        
        XCTAssertEqual(canadaInfo.rows.count, expectedRows)
    }
    
    func testCanadaInfoRowsReturnsCorrectTitle() {
        let expectedTitle = "Beavers"
        let row = canadaInfo.rows[0]
        
        XCTAssertEqual(row.title, expectedTitle)
    }
    
    func testCanadaInfoRowsReturnsCorrectImageRef() {
        let expectedImageURL = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        let row = canadaInfo.rows[0]
        
        XCTAssertEqual(row.imageHref, expectedImageURL)
    }

    func testCanadaInfoRowsReturnsCorrectDescription() {
        let expectedDescription = "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony"
        let row = canadaInfo.rows[0]
        
        XCTAssertEqual(row.description, expectedDescription)
    }

    
    override func tearDown() {
        super.tearDown()
    }
    
}
