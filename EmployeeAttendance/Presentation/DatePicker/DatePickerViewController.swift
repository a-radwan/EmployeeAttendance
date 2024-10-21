//
//  DatePickerViewController.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//


import UIKit
import SwiftUI

@objc protocol DatePickerViewControllerDelegate: AnyObject {
    func didPickDate(_ date: Date)
}

class DatePickerViewController: UIViewController {
    
    @objc weak var delegate: DatePickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = DatePickerView(delegate: self)
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.sizingOptions = .intrinsicContentSize
        
        hostingController.didMove(toParent: self)
        hostingController.safeAreaRegions = []
        
    }
    
}

extension DatePickerViewController: DatePickerViewDelegate {
    func didSelectDate(_ date: Date) {
        self.delegate?.didPickDate(date)
        
    }
}
