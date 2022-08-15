//
//  UserInfoView.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 15.08.22.
//

import UIKit
import SnapKit

class UserInfoView: UIView {
    // MARK: - Views
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        imageView.layer.cornerRadius = Metric.photoImageViewRadius
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .secondarySystemBackground
        return imageView
    }()
    
    private lazy var iconsStackView = createStackView(axis: .vertical,
                                                      distribution: .equalCentering,
                                                      alignment: .top,
                                                      spacing: 11)

    private lazy var avatrIcon = createIcon(name: "person")
    private lazy var calendarIcon = createIcon(name: "calendar")
    private lazy var genderIcon = createIcon(name: "face.smiling")
    
    private lazy var textStackView = createStackView(axis: .vertical,
                                                         distribution: .fillProportionally,
                                                         alignment: .leading,
                                                         spacing: 12)
    
    lazy var userNameTextField = createTextFields(placeholder: "Name")
    lazy var birthdayDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date.now
        datePicker.datePickerMode = .date
        datePicker.isEnabled = false
        return datePicker
    }()
    
    lazy var genderControl: UISegmentedControl = {
        let segmentedItems = ["Male", "Female"]
        let font = UIFont.systemFont(ofSize: 17)
        let segmentedControl = UISegmentedControl(items: segmentedItems)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.black]
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.lightGray]
        segmentedControl.setTitleTextAttributes(selectedAttribute, for: .selected)
        segmentedControl.setTitleTextAttributes(normalAttribute, for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isEnabled = false
        return segmentedControl
    }()
    
    private lazy var separatorView = createSeparatorView()
    private lazy var separatorSecondView = createSeparatorView()
    private lazy var separatorLastView = createSeparatorView()

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
        addSubviewsForAutoLayout([photoImageView,
                                  iconsStackView,
                                  textStackView,])
        iconsStackView.addArrangedSubviewsForAutoLayout([avatrIcon,
                                                         calendarIcon,
                                                         genderIcon])
        textStackView.addArrangedSubviewsForAutoLayout([userNameTextField,
                                                        separatorView,
                                                        birthdayDatePicker,
                                                        separatorSecondView,
                                                        genderControl,
                                                        separatorLastView])
    }
    
    private func setupLayout() {
        photoImageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(Metric.photoImageViewTopInset)
            maker.height.width.equalTo(Metric.photoImageViewSize)
        }
        
        iconsStackView.snp.makeConstraints { maker in
            maker.top.equalTo(photoImageView.snp.bottom).inset(-12)
            maker.leading.equalToSuperview().inset(22)
            maker.width.equalTo(34)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(22)
            maker.height.width.equalTo(Metric.separatorHeight)
        }
        
        separatorSecondView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(22)
            maker.height.width.equalTo(Metric.separatorHeight)
        }
        
        separatorLastView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(22)
            maker.height.width.equalTo(Metric.separatorHeight)
        }
        
        textStackView.snp.makeConstraints{ maker in
            maker.top.equalTo(photoImageView.snp.bottom).inset(-20)
            maker.leading.equalTo(iconsStackView.snp.trailing).inset(-22)
            maker.trailing.equalToSuperview().inset(22)
        }
    }
}

// MARK: - Constants

extension UserInfoView {
    
    enum Metric {
        static let photoImageViewSize: CGFloat = 250
        static let photoImageViewRadius: CGFloat = Metric.photoImageViewSize/2
        static let photoImageViewTopInset: CGFloat = 88
        static let separatorHeight: CGFloat = 1
    }
    
    enum Strings {
        static let printName: String = "Print your name here"
        static let newUserButtonTitle = "Press"
    }
}
