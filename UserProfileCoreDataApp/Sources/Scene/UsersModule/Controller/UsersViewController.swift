//
//  UsersViewController.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate {
    // MARK: - Properties
    
    var presenter: UsersPresenterProtocol?
    var hasLoginData: Bool { !(usersView?.textField.text).isEmptyOrNil }
    
    // MARK: - View
    
    private var usersView: UsersView? {
        guard isViewLoaded
        else {
            return nil }
        return view as? UsersView
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = UsersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
}

// MARK: - Settings

extension UsersViewController {
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = Strings.navigationTitle
    }
    
    func setupView() {
        usersView?.newUserButton.isEnabled = hasLoginData
        usersView?.textField.delegate = self
        usersView?.tableView.delegate = self
        usersView?.tableView.dataSource = self
        usersView?.newUserButton.addTarget(self,
                                           action: #selector(saveUser),
                                           for: .touchUpInside)
    }
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter?.userInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let user = presenter?.userInfo?[indexPath.row]
        cell.textLabel?.text = user?.value(forKeyPath: CoreDataKeyPath.userFullName.rawValue) as? String
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: Strings.delete) { _, _, callback in
            guard let user = self.presenter?.userInfo?[indexPath.row]
            else {
                return }
            self.presenter?.deleteUser(userName: user)
            callback(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let user = presenter?.userInfo?[indexPath.row]
        guard let userName = user?.value(forKeyPath: CoreDataKeyPath.userFullName.rawValue) as? String
        else {
            return }
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showUserInfoCcontroller(userName: userName)
    }
}

// MARK: - UITextFieldDelegate

extension UsersViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentText = usersView?.textField.text ?? ""
        usersView?.newUserButton.isEnabled = hasLoginData
        guard let stringRange = Range(range, in: currentText)
        else {
            return false }
        let updatedText = currentText.replacingCharacters(in: stringRange,
                                                          with: string)
        return updatedText.count <= 36
    }
}

// MARK: - UsersViewProtocol

extension UsersViewController: UsersViewProtocol {
    
    func reload() {
        presenter?.updateUsers()
        usersView?.tableView.reloadData()
    }
}

// MARK: - Actions

extension UsersViewController {
    
    @objc
    func saveUser() {
        let userName: String = usersView?.textField.text ?? ""
        presenter?.saveFullName(name: userName)
        usersView?.textField.text = nil
    }
}

// MARK: - Constants

extension UsersViewController {
    
    enum Strings {
        static let navigationTitle: String = "Users"
        static let delete: String = "Delete"
    }
}
