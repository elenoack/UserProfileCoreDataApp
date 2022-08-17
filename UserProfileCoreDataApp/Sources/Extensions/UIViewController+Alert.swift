//
//  UIViewController+Alert.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 15.08.22.
//

import Foundation

import UIKit

extension UIViewController {
    
    func showActionSheet(title: String? = nil,
                         message: String? = nil,
                         showCancel: Bool = true,
                         actions: [UIAlertAction] = [],
                         from sourceView: UIView? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        for action in actions {
            alert.addAction(action)
        }
        
        if showCancel {
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel)
            alert.addAction(cancelAction)
        }
        
        if let sourceView = sourceView {
            alert.popoverPresentationController?.sourceView = sourceView
        } else {
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.permittedArrowDirections = []
        }

        present(alert, animated: true, completion: nil)
    }
    
}
