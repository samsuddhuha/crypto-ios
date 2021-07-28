//
//  StringExtension.swift
//  crypto
//
//  Created by Samsud Dhuha on 27/07/21.
//

import Foundation
 
extension String{
    func characterAt(_ index: Int) -> Character? {
        guard index < count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
