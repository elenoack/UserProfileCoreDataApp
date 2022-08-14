//
//  UsersView.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import UIKit
import SnapKit

class UsersView: UIView {
    // MARK: - Views
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.printName
        textField.font = UIFont.systemFont(ofSize: Metric.primaryFontSize)
        textField.textAlignment = .left
        textField.textColor = .darkGray
        textField.backgroundColor = .systemGray5
        textField.becomeFirstResponder()
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var newUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.newUserButtonTitle, for: .normal)
        button.backgroundColor =  #colorLiteral(red: 0.2593759298, green: 0.5698557496, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Metric.primaryFontSize)
        button.tintColor = .white
        button.layer.cornerRadius = Metric.radius
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubviewsForAutoLayout([textField,
                                  newUserButton,
                                  tableView])
    }
    
    private func setupLayout() {
        textField.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(Metric.inset)
            maker.top.equalToSuperview().inset(Metric.textFieldTopInset)
            maker.height.equalTo(Metric.textFieldHeight)
        }
        
        newUserButton.snp.makeConstraints { maker in
            maker.left.right.equalTo(textField)
            maker.top.equalTo(textField.snp.bottom).inset(-Metric.inset)
            maker.height.equalTo(Metric.textFieldHeight)
            }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(newUserButton.snp.bottom).inset(-Metric.inset)
            maker.right.left.bottom.equalToSuperview()
        }
    }
}

// MARK: - Constants

extension UsersView {
    
    enum Metric {
        static let radius: CGFloat = 6
        static let primaryFontSize: CGFloat = 18
        static let inset: CGFloat = 12
        static let textFieldHeight: CGFloat = 38
        static let textFieldTopInset: CGFloat = 112
    }
    
    enum Strings {
        static let printName: String = "Print your name here"
        static let newUserButtonTitle = "Press"
    }
}
