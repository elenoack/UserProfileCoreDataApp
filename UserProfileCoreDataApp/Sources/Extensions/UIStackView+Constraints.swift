//
//  UIStackView+Constraints.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 14.08.22.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviewsForAutoLayout(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
