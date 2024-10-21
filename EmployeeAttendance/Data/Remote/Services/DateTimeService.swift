//
//  DateTimeService.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

protocol DateTimeService {
    func fetchInitialDateTime() async -> Date?
}

class MockDateTimeService: DateTimeService {
    
    func fetchInitialDateTime() async -> Date? {
        
        // Simulate network
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // Simulate 2-second network delay

        //Mock Response
        let date = Calendar.current.date(bySettingHour: 6, minute: 30, second: 0, of: Date()) ?? Date()
        let mockResponse = "{\"dateTime\": \"\(date.toString())\"}"
        
        guard let data = mockResponse.data(using: .utf8) else {
            return nil
        }
        
        // Parse the response
        do {
            let dateTimeResponse = try JSONDecoder().decode(DateTimeResponse.self, from: data)
            return dateTimeResponse.date
        } catch {
            print("Failed to parse response: \(error)")
            return nil
        }
    }
}
