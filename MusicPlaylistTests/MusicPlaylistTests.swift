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
    
    func validateMusicList(_ list: MusicListResponse) throws{
        print(list.results.count)
        for item in list.results{
            if item.wrapperType == .unsupported{ continue }
            XCTAssertNotNil(item.name)
            XCTAssertNotNil(item.explicitness)
            XCTAssertNotNil(item.censoredName)
            XCTAssertNotNil(item.viewURL)
        }
    }

    func testDecodable1() throws {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "1", ofType: "txt")
        
        let json = try String(contentsOfFile: path!).data(using: .utf8)!
        
        let list = try JSONDecoder().decode(MusicListResponse.self, from: json)
        
        try validateMusicList(list)
    }
    
    func testDecodable2() throws {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "2", ofType: "txt")
        
        let json = try String(contentsOfFile: path!).data(using: .utf8)!
        
        let list = try JSONDecoder().decode(MusicListResponse.self, from: json)
        
        try validateMusicList(list)
    }
    
    func testDecodable3() throws {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "3", ofType: "txt")
        
        let json = try String(contentsOfFile: path!).data(using: .utf8)!
        
        let list = try JSONDecoder().decode(MusicListResponse.self, from: json)
        
        try validateMusicList(list)
    }
    
    func validateRequest(_ request: MusicListRequest) throws{
        let expectation = self.expectation(description: "fetch")
        var list: MusicListResponse?
        
        request.request(completion: {result in
            do{
                switch result {
                case .success(let response):
                    list = response
                    expectation.fulfill()
                case .failure(let failure):
                    throw failure
                }
            }catch(let error){
                assertionFailure(error.localizedDescription)
            }
        })
        
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(list)
        try validateMusicList(list!)
    }

    
    func testMusicListRequest() throws{
        let request = MusicListRequest(term: "a")
        try validateRequest(request)
    }
    
    func testMusicListRequestOffset() throws{
        let request = MusicListRequest(pageInd: 1, term: "a")
        try validateRequest(request)
    }
    
    func testMusicListRequestSearch() throws{
        let request = MusicListRequest(term: "test")
        try validateRequest(request)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
