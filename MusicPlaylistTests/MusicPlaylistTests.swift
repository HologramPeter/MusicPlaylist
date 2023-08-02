//
//  MusicPlaylistTests.swift
//  MusicPlaylistTests
//
//  Created by Peter Ho on 2/8/2023.
//

import XCTest
@testable import MusicPlaylist

final class MusicPlaylistTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodable() throws {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "1", ofType: "txt")
        
        let json = try String(contentsOfFile: path!).data(using: .utf8)!
        
        let list = try JSONDecoder().decode(MusicListResponse.self, from: json)
        XCTAssertEqual(list.resultCount, list.results.count)
        
        for item in list.results{
            XCTAssertNotNil(item.name)
            XCTAssertNotNil(item.explicitness)
            XCTAssertNotNil(item.censoredName)
            XCTAssertNotNil(item.viewURL)
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
