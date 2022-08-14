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
}
