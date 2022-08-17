//
//  UserInfoView.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 15.08.22.
//

import UIKit
import SnapKit
import UniformTypeIdentifiers

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

class UserInfoView: UIView {
    // MARK: - Views
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Strings.avatarImage))
        imageView.layer.cornerRadius = Metric.photoImageViewRadius
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .secondarySystemBackground
        return imageView
    }()
    
    private lazy var iconsStackView = createStackView(axis: .vertical,
                                                      distribution: .equalCentering,
                                                      alignment: .top,
                                                      spacing: Metric.iconsStackViewSpacing)
    
    private lazy var avatarIcon = createIcon(name: Strings.avatarIcon)
    private lazy var calendarIcon = createIcon(name: Strings.calendarIcon)
    private lazy var genderIcon = createIcon(name: Strings.genderIcon)
    private lazy var textStackView = createStackView(axis: .vertical,
                                                     distribution: .fillProportionally,
                                                     alignment: .leading,
                                                     spacing: Metric.textStackViewSpacing)
    
    lazy var userNameTextField = createTextFields(placeholder: Strings.placeholder)
    lazy var birthdayDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date.now
        datePicker.datePickerMode = .date
        datePicker.isEnabled = false
        return datePicker
    }()
    
    lazy var genderControl: UISegmentedControl = {
        let segmentedItems = [Gender.male.rawValue, Gender.female.rawValue]
        let font = UIFont.systemFont(ofSize: Metric.systemFont)
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
    
    lazy var photoLibraryPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [UTType.image.identifier]
        picker.allowsEditing = true
        return picker
    }()
    
    lazy var photoCameraPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [UTType.image.identifier]
        picker.allowsEditing = true
        return picker
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
        addSubviewsForAutoLayout([photoImageView,
                                  iconsStackView,
                                  textStackView,])
        iconsStackView.addArrangedSubviewsForAutoLayout([avatarIcon,
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
            maker.top.equalTo(photoImageView.snp.bottom).inset(-Metric.iconsStackViewTopInset)
            maker.leading.equalToSuperview().inset(Metric.inset)
            maker.width.equalTo(Metric.iconsStackViewWidth)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(Metric.inset)
            maker.height.equalTo(Metric.separatorHeight)
        }
        
        separatorSecondView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(Metric.inset)
            maker.height.equalTo(Metric.separatorHeight)
        }
        
        separatorLastView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(Metric.inset)
            maker.height.equalTo(Metric.separatorHeight)
        }
        
        textStackView.snp.makeConstraints{ maker in
            maker.top.equalTo(photoImageView.snp.bottom).inset(-Metric.textStackViewTopInset)
            maker.leading.equalTo(iconsStackView.snp.trailing).inset(-Metric.inset)
            maker.trailing.equalToSuperview().inset(Metric.inset)
        }
    }
}

// MARK: - Constants

extension UserInfoView {
    
    enum Metric {
        static let photoImageViewSize: CGFloat = 170
        static let photoImageViewRadius: CGFloat = Metric.photoImageViewSize/2
        static let photoImageViewTopInset: CGFloat = 88
        static let separatorHeight: CGFloat = 1
        static let iconsStackViewTopInset: CGFloat = 12
        static let iconsStackViewWidth: CGFloat = 34
        static let iconsStackViewSpacing: CGFloat = 11
        static let inset: CGFloat = 22
        static let textStackViewTopInset: CGFloat = 20
        static let textStackViewSpacing: CGFloat = 12
        static let systemFont: CGFloat = 17
    }
    
    enum Strings {
        static let avatarImage: String = "avatar"
        static let avatarIcon: String = "person"
        static let calendarIcon: String = "calendar"
        static let genderIcon: String = "face.smiling"
        static let placeholder: String = "Name"
    }
}
