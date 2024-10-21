//
//  DatePickerViewModelTests.swift
//  EmployeeAttendanceTests
//
//  Created by Ahd on 10/22/24.
//

import XCTest

import Combine
@testable import EmployeeAttendance

class DatePickerViewModelTests: XCTestCase {
    
    var viewModel: DatePickerViewModel!
    var mockApiService: MockDateTimeService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockApiService = MockDateTimeService()
        viewModel = DatePickerViewModel(apiService: mockApiService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockApiService = nil
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
        
    }
        
    func testValidation_WhenDateIsInFuture() {

        let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        viewModel.selectedDate = futureDate

        viewModel.validateDate()

        XCTAssertEqual(viewModel.validationErrorMessage, "Selected date cannot be in the future.")
        XCTAssertFalse(viewModel.isSubmitButtonEnabled)
    }
    
    func testValidation_WhenDateIsNotInFuture() {

        let pastDate = Date()
        viewModel.selectedDate = pastDate

        viewModel.validateDate()

        XCTAssertNil(viewModel.validationErrorMessage)
        XCTAssertTrue(viewModel.isSubmitButtonEnabled)
    }
    
    func testSubmitDate_WhenDateIsValid() {

        let validDate = Date().toString().toDate()
        viewModel.selectedDate = validDate!
        viewModel.isSubmitButtonEnabled = true

        viewModel.submitDate()

        let savedDate = CoreDataManager.shared.fetchMostRecentCheckInDate()
        XCTAssertEqual(savedDate, validDate)
    }

}
