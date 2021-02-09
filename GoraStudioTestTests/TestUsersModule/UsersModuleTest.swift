//
//  UsersModuleTest.swift
//  GoraStudioTestTests
//
//  Created by Александр on 08.02.2021.
//

import XCTest
@testable import GoraStudioTest

class UsersMockView: UsersTableViewProtocol {
    
    var testTitle: String?
    
    func succsess(users: [User]?) {
        self.testTitle = users?.first?.name
    }
    
    func failure(error: Error) {
        self.testTitle = "Error"
    }
}

class UsersModuleTest: XCTestCase {
    
    var view: UsersMockView?
    var user: User?
    var presenter: UsersPresenter?

    override func setUpWithError() throws {
        let geo = Geo(lat: "TestLat", lng: "TestLng")
        let company = Company(name: "TestCompanyName", catchPhrase: "TestcatchPhrase", bs: "Testbs")
        let adress = Address(street: "TestAdress", suite: "Testsuite", city: "TestCity", zipcode: "TestZip", geo: geo)
        
        view = UsersMockView()
        presenter = UsersPresenter(view: view, networkDataFetcher: nil, router: nil)
        user = User(id: 000, name: "Test", username: "Testel", email: "Testemail", address: adress, phone: "TestPhone", website: "TestWebsite", company: company)
        presenter?.users = [user!]
    }

    override func tearDownWithError() throws {
        view = nil
        user = nil
        presenter = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testModeuleIsNotNill() {
        XCTAssertNotNil(view, "view is not nill")
        XCTAssertNotNil(user, "user is not nill")
        XCTAssertNotNil(presenter, "presenter is not nill")
    }
    
    func testView() {
        presenter?.view?.succsess(users: presenter?.users)
        XCTAssertEqual(view?.testTitle, "Test")
    }
    
    func testUser() {
        XCTAssertEqual(user?.name, "Test")
        XCTAssertEqual(user?.id, 000)
    }

}
