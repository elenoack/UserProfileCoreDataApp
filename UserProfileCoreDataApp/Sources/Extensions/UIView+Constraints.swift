//
//  UIView+Constraints.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import UIKit

extension UIView {
    
    func addSubviewsForAutoLayout(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func createTextFields(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textAlignment = .left
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.becomeFirstResponder()
        textField.isEnabled = false
        textField.isUserInteractionEnabled = true
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        return textField
    }
    
    func createStackView(axis: NSLayoutConstraint.Axis,
                         distribution: UIStackView.Distribution,
                         alignment: UIStackView.Alignment,
                         spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.clear
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        stackView.backgroundColor = .clear
        return stackView
    }
    
    func createIcon(name: String) -> UIImageView {
        let icon = UIImage(systemName: name)
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        return imageView
    }
    
    func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }
    
}
