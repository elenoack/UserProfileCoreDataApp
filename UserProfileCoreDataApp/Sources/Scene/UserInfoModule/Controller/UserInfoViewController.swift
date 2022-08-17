//
//  UserInfoViewController.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 14.08.22.
//

import UIKit

class UserInfoViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: UserInfoPresenterProtocol?
    private var isPushButton = false
    private var gender: String?
    private var imageData: Data?
    
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
        presenter?.getUser()
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
        [userInfoView?.userNameTextField,
         userInfoView?.birthdayDatePicker,
         userInfoView?.genderControl].forEach {
            $0?.isEnabled = isPushButton
        }
        userInfoView?.isUserInteractionEnabled = isPushButton
    }
    
    func setupActions() {
        userInfoView?.genderControl.addTarget(nil, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseAvatar))
        userInfoView?.photoImageView.addGestureRecognizer(tap)
    }
}

// MARK: - UserInfoViewProtocol

extension UserInfoViewController: UserInfoViewProtocol {
    
    func displayUser(userName: String?,
                     birthday: Date?,
                     gender: String?,
                     avatar: Data?) {
        userInfoView?.userNameTextField.text = userName
        if avatar == nil {
            userInfoView?.photoImageView.image = UIImage(named: "avatar")
        } else {
            userInfoView?.photoImageView.image = UIImage(data: avatar!) }
        userInfoView?.birthdayDatePicker.date = birthday ?? .now
        switch gender {
        case Gender.male.rawValue:
            userInfoView?.genderControl.selectedSegmentIndex = 0
        case Gender.female.rawValue:
            userInfoView?.genderControl.selectedSegmentIndex = 1
        default:
            break
        }
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
    func chooseAvatar(sender: UITapGestureRecognizer) {
        let galleryAction = UIAlertAction(title: Strings.alertTitleGallery,
                                          style: .default,
                                          handler: addFromGallery)
        let photoAction = UIAlertAction(title: Strings.alertTitlePhoto,
                                        style: .default,
                                        handler: doNewPhoto)
        showActionSheet(actions: [galleryAction,
                                  photoAction,])
    }
    
    @objc
    private func editButtonAction() {
        isPushButton.toggle()
        setupView()
        switch isPushButton {
        case true:
            editButton.title = Strings.navigationButtonSave
            editButton.tintColor = .systemRed
        case false:
            editButton.title = Strings.navigationButtonEdit
            editButton.tintColor = .black
            let userName = userInfoView?.userNameTextField.text
            let birthday = userInfoView?.birthdayDatePicker.date
            presenter?.saveUser(userName: userName,
                                birthday: birthday,
                                gender: gender,
                                avatar: imageData)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension UserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage
        else {
            fatalError("\(Strings.error)\(info)")
        }
        imageData = image.pngData() as Data?
        userInfoView?.photoImageView.image = image
        userInfoView?.photoImageView.contentMode = .scaleAspectFill
        userInfoView?.photoImageView.clipsToBounds = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func addFromGallery(action: UIAlertAction) {
        userInfoView?.photoLibraryPicker.delegate = self
        guard let picker = userInfoView?.photoLibraryPicker
        else {
            return }
        present(picker, animated: true, completion: nil)
    }
    
    func doNewPhoto(action: UIAlertAction) {
        userInfoView?.photoCameraPicker.delegate = self
        guard let picker = userInfoView?.photoCameraPicker
        else {
            return }
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - Constants

extension UserInfoViewController {
    
    enum Strings {
        static let navigationButtonSave: String = "Save"
        static let navigationButtonEdit: String = "Edit"
        static let alertTitleGallery: String = "Choose from gallery"
        static let alertTitlePhoto: String = "Take photo"
        static let error: String = "Expected a dictionary containing an image, but was provided the following: "
    }
}
