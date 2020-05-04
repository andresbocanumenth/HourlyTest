//
//  FileType.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 3/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

enum FileType {
    case folder, compressed, code, unknown, image, pdf
}

extension FileType {
    var icon : UIImage? {
        switch self {
            case .compressed:
                return UIImage(named: "archivebox")
            case .folder:
                return UIImage(named: "folder")
            case .code:
                return UIImage(named: "code")
            case .unknown, .image, .pdf:
                return UIImage(named: "questionmark")
        }
    }
}
