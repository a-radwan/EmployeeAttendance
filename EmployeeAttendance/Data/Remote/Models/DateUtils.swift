//
//  DateUtils.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
extension Date {
    func toString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

