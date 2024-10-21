//
//  DatePickerView.swift
//  EmployeeAttendance
//
//  Created by Ahd on 10/15/24.
//


import SwiftUI

protocol DatePickerViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

struct DatePickerView: View {
    
    @StateObject private var viewModel = DatePickerViewModel()
    @Environment(\.dismiss) private var dismiss
    
    weak var delegate: DatePickerViewDelegate?
    
    init(delegate: DatePickerViewDelegate) {
        self.delegate = delegate
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                titleSection
                Spacer()
                
                if viewModel.isLoading {
                    loadingView
                } else if let message = viewModel.errorMessage {
                    errorView(with: message)
                } else {
                    datePickerSection
                }
                
                Spacer()
                Spacer()
            }
            .padding()
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
    
    // MARK: - View Sections
    
    private var titleSection: some View {
        Text("Check-In")
            .font(.system(size: 30, weight: .bold))
            .padding(.top, 110)
    }
    
    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .font(.callout)
    }
    
    private func errorView(with message: String) -> some View {
        VStack(spacing: 10) {
            Text(message)
                .foregroundColor(.gray)
                .font(.callout)
            
            Button(action: {
                Task {
                    await viewModel.loadInitialDate()
                }
            }) {
                Text("Try again")
                    .font(.subheadline)
            }
            .padding()
        }
    }
    
    private var datePickerSection: some View {
        VStack(spacing: 20) {
            Text("Select a date and time to check in")
                .font(.title3)
            
            DatePicker(
                "Select a time to check In",
                selection: $viewModel.selectedDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.automatic)
            .labelsHidden()
            .padding()
            
            // Show validation invalid DateTime message
            if let validationErrorMessage = viewModel.validationErrorMessage {
                Text(validationErrorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
            
            // Submit button
            Button(action: {
                viewModel.submitDate()
                delegate?.didSelectDate(viewModel.selectedDate)
                dismiss()
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isSubmitButtonEnabled ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .disabled(!viewModel.isSubmitButtonEnabled)
        }
    }
    
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDelegate = DatePickerMockDelegate()
        DatePickerView(delegate: mockDelegate)
    }
}

// A mock delegate for the PreviewProvider
class DatePickerMockDelegate: DatePickerViewDelegate {
    func didSelectDate(_ date: Date) {}
}
