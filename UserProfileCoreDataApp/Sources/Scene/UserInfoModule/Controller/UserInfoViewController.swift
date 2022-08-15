//
//  UserInfoViewController.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 14.08.22.
//

import UIKit

class UserInfoViewController: UIViewController {
    // MARK: - Properties
    
    enum Gender: String {
        case male = "Male"
        case female = "Female"
    }
    
    var presenter: UserInfoPresenterProtocol?
    private var isPushButton = true
    private var gender: String = ""
    
    // MARK: - View
    
    private var userInfoView: UserInfoView? {
        guard isViewLoaded else {
            return nil }
        return view as? UserInfoView
    }
    
    private lazy var editButton = UIBarButtonItem(title: Strings.navigationButtonEdit,
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(editButtonAction))
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = UserInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupView()
        setupActions()
    }
}

// MARK: - Settings

extension UserInfoViewController {
    
    func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = editButton
    }
    
    func setupView() {
        let userName = presenter?.user?.value(forKeyPath: CoreDataKeyPath.userFullName.rawValue) as? String
        let birthday = presenter?.user?.value(forKeyPath: CoreDataKeyPath.birthday.rawValue) as? Date
        userInfoView?.userNameTextField.text = userName
        userInfoView?.birthdayDatePicker.date = birthday ?? .now
        let gender = presenter?.user?.value(forKeyPath: CoreDataKeyPath.gender.rawValue) as? String
        switch gender {
        case Gender.male.rawValue:
            userInfoView?.genderControl.selectedSegmentIndex = 0
        case Gender.female.rawValue:
            userInfoView?.genderControl.selectedSegmentIndex = 1
        default:
            break
        }
    }
    
    func setupActions() {
        userInfoView?.genderControl.addTarget(nil,
                                              action: #selector(segmentDidChange(_:)),
                                              for: .valueChanged)
    }
}

// MARK: - UserInfoViewProtocol

extension UserInfoViewController: UserInfoViewProtocol {
    
    func reload() {
        setupView()
    }
}

// MARK: - Action

extension UserInfoViewController {
    
    @objc
    private func segmentDidChange(_ sender: UISegmentedControl) {
        if userInfoView?.genderControl.selectedSegmentIndex == 0 {
            gender = Gender.male.rawValue
        } else {
            gender = Gender.female.rawValue
        }
    }
    
    @objc
    func editButtonAction() {
        switch isPushButton {
        case true:
            editButton.title = Strings.navigationButtonSave
            editButton.tintColor = .systemBlue
            userInfoView?.userNameTextField.isEnabled = true
            userInfoView?.birthdayDatePicker.isEnabled = true
            userInfoView?.genderControl.isEnabled = true
            isPushButton = false
        case false:
            editButton.title = Strings.navigationButtonEdit
            editButton.tintColor = .black
            guard let user = presenter?.user
            else {
                return }
            user.fullName = userInfoView?.userNameTextField.text
            user.birthday = userInfoView?.birthdayDatePicker.date
            user.gender = gender
            presenter?.saveUser(user: user)
            userInfoView?.userNameTextField.isEnabled = false
            userInfoView?.birthdayDatePicker.isEnabled = false
            userInfoView?.genderControl.isEnabled = false
            isPushButton = true
            
        }
    }
}

// MARK: - Constants

extension UserInfoViewController {
    
    enum Strings {
        static let navigationButtonSave: String = "Save"
        static let navigationButtonEdit: String = "Edit"
    }
}
