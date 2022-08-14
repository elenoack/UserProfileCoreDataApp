//
//  String+Extensions.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self?.isEmpty != false
    }
}
