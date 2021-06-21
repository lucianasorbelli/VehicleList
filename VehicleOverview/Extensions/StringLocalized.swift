//
//  StringLocalized.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 19/06/2021.
//

import Foundation

extension String {
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "\(tableName)")
    }
}
