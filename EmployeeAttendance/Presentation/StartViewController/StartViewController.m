//
//  StartViewController.m
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

#import "StartViewController.h"
#import "StartViewModel.h"
#import "EmployeeAttendance-Swift.h"

//Constants
static CGFloat const kHorizontalPadding = 30.0;
static CGFloat const kVerticalPadding = 30.0;
static CGFloat const kButtonHeight = 50.0;

@interface StartViewController () <DatePickerViewControllerDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *startButton;

@property (strong, nonatomic) StartViewModel *viewModel;

@end

@implementation StartViewController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _viewModel = [[StartViewModel alloc] init];
        [self setupUI];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Bind view model updates
    [self bindViewModel];
    
    // Load initial content
    [self.viewModel fetchMostRecentCheckInRecord];
}

#pragma mark - UI Setup

- (void)setupUI {
    
    // Set background color
    self.view.backgroundColor = [UIColor whiteColor];
    

    // titleLabel
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Attendance";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // messageLabel
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.text = self.viewModel.welcomeMessage;
    self.messageLabel.font = [UIFont systemFontOfSize:18];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // startButton
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.startButton setBackgroundColor:[UIColor systemBlueColor]];
    self.startButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.startButton.layer.cornerRadius = 10;
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.startButton addTarget:self action:@selector(didClickStartButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.startButton];
    
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    
    // titleLabel Constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:70],
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:safeArea.centerXAnchor]
    ]];
    
    // messageLabel Constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.messageLabel.centerXAnchor constraintEqualToAnchor:safeArea.centerXAnchor],
        [self.messageLabel.centerYAnchor constraintEqualToAnchor:safeArea.centerYAnchor constant: - (kVerticalPadding + kButtonHeight)/2.0],
        [self.messageLabel.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:kHorizontalPadding],
        [self.messageLabel.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-kHorizontalPadding]
    ]];
    
    // startButton Constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.startButton.topAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor constant:kVerticalPadding],
        [self.startButton.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:kHorizontalPadding],
        [self.startButton.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-kHorizontalPadding],
        [self.startButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

#pragma mark - View Model Binding

- (void)bindViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdateMessage = ^{
        weakSelf.messageLabel.text = weakSelf.viewModel.welcomeMessage;
    };
}

#pragma mark - Actions

- (void)didClickStartButton:(id)sender {
    
    DatePickerViewController *vc = [[DatePickerViewController alloc] init];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - DatePickerViewControllerDelegate

- (void)didPickDate:(NSDate *)date {
    [self.viewModel handleCheckInWithDate:date];
}

@end
