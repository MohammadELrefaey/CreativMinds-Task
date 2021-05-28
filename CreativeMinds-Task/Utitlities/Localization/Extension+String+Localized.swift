//
//  Extension+String+Localized.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/28/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
