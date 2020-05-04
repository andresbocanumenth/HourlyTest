//
//  String+Extension.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 3/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import Foundation

public extension String {
    var toURL: URL? {
        return URL(string: self)
    }
    
    func getImageDocumentPath() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentsDirectory.appendingPathComponent(self)
        return fileURL
    }
}
