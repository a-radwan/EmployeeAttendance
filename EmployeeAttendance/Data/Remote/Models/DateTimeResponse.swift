//
//  DateTimeResponse.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/19/24.
//

import Foundation

struct DateTimeResponse: Decodable {
    let dateTime: String
    
    var date: Date? {
        return dateTime.toDate()
    }
}
