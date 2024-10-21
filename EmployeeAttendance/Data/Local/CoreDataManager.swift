//
//  CoreDataManager.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

import Foundation
import CoreData

@objc class CoreDataManager: NSObject {
    
    @objc static let shared = CoreDataManager()
    private let context: NSManagedObjectContext
    
    
    private override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to get AppDelegate instance.")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: - Employee
    // Save the check-in date & companyName
    func saveCheckInDate(date: Date, companyName: String = "HighTech") {
        
        // Fetch company or creat it
        let company = fetchOrCreateCompany(named: companyName)
        
        // Create employee
        let employee = Employee(context: context)
        employee.check_in_date_time = date.toString()
        employee.company = company
        
        do {
            try context.save()
            print("Check-in date saved successfully!")
        } catch {
            print("Failed to save check-in date: \(error)")
        }
    }
    
    // Fetch the most recent check-in date
    func fetchMostRecentCheckInDate() -> Date? {
        if let mostRecentCheckInString = fetchMostRecentCheckInRecord()?.check_in_date_time {
            return mostRecentCheckInString.toDate()
        }
        return nil
    }
    
    // Fetch the most recent Employee check-in record
    @objc func fetchMostRecentCheckInRecord() -> Employee? {
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: EmployeeKeys.checkInDateTime, ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch most recent Employee record: \(error)")
            return nil
        }
    }
    
    //MARK: - Company
    private func fetchOrCreateCompany(named companyName: String) -> Company {
        return fetchCompany(named: companyName) ?? createCompany(named: companyName)
    }
    
    // Fetch company by name
    private func fetchCompany(named companyName: String) -> Company? {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(CompanyKeys.name) == %@", companyName)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch company: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Create a company
    private func createCompany(named companyName: String) -> Company {
        let newCompany = Company(context: context)
        newCompany.name = companyName
        return newCompany
    }
}
