//
//  DatePickerViewModel.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

import SwiftUI
import Combine

class DatePickerViewModel: ObservableObject {
    
    @Published var selectedDate: Date = Date() {
        didSet {
            validateDate()
        }
    }
    @Published var validationErrorMessage: String?
    @Published var isSubmitButtonEnabled: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    
    private let coreDataManager = CoreDataManager.shared
    private let apiService: DateTimeService
    
    init(apiService: DateTimeService = MockDateTimeService()) {
        
        self.apiService = apiService
        Task { [weak self] in
            await self?.loadInitialDate()
        }
    }
    
    func loadInitialDate() async {

        await MainActor.run { [weak self] in
            self?.isLoading = true
        }

        defer {
            Task {
                await MainActor.run { self.isLoading = false }
            }
        }
        
        if let mostRecentDate = coreDataManager.fetchMostRecentCheckInDate() {
            //Not first time, there is a record in DB
            await MainActor.run { [weak self] in
                self?.selectedDate = mostRecentDate
            }
        } else {
            // Fetch the initial date
            if let apiDate = await apiService.fetchInitialDateTime() {
                await MainActor.run { [weak self] in
                    self?.selectedDate = apiDate
                }
            } else {
                // API call failed, show the error message
                await MainActor.run { [weak self] in
                    self?.errorMessage = "Failed to load the initial date."
                }
            }
        }
    }
    
    func submitDate() {
        guard isDateValid else { return }
        coreDataManager.saveCheckInDate(date: selectedDate)
    }

    //MARK: - Validation
    
    var isDateValid: Bool {
        return selectedDate <= Date()
    }
    func validateDate() {
        if !isDateValid {
            validationErrorMessage = "Selected date cannot be in the future."
            isSubmitButtonEnabled = false
        } else {
            validationErrorMessage = nil
            isSubmitButtonEnabled = true
        }
    }
    
    
}
