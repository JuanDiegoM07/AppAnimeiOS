//
//  AppAnimeiOSTests.swift
//  AppAnimeiOSTests
//
//  Created by Juan Diego Marin on 22/11/22.
//

import XCTest
@testable import AppAnimeiOS

class AppAnimeiOSTests: XCTestCase {
    
    // MARK: - Private Properties
    private var requestExpectation: XCTestExpectation?
    // MARK: - Subject under test
    private var viewModel: AnimeViewModel!
    // MARK: - Mock
    private var repositoryMock: AnimesRepositoryMock!
    

    override func setUp() {
        super.setUp()
        repositoryMock = AnimesRepositoryMock()
        viewModel = AnimeViewModel(repository: repositoryMock)
    }

    override func tearDown() {
        super.tearDown()
        repositoryMock = nil
        viewModel = nil
    }


    // MARK Tests getAnime
    
    func testGetAnime() {
        // Given
        repositoryMock.animes = AnimeFake.dataInfo
        // When
        getAnimes()
        // Then
        XCTAssertEqual(requestExpectation?.expectationDescription, ResponseExpectation.ok.rawValue)
    }

}

private extension AppAnimeiOSTests {
    
    func getAnimes() {
        requestExpectation = expectation(description: ResponseExpectation.go.rawValue)
        viewModel.success = {
            self.requestExpectation?.expectationDescription = ResponseExpectation.ok.rawValue
            self.requestExpectation?.fulfill()
        }
        viewModel.getAnime()
        if let requestExpectation = requestExpectation {
            wait(for: [requestExpectation]
                 , timeout: 1)
        }
    }
}
