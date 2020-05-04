//
//  DropboxEntry.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 2/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import SwiftyDropbox

struct DropboxEntry {
    var name: String
    var path: String?
    var size: UInt64?
    var fileType: FileType = .unknown
    
    init(entry: Files.Metadata) {
        name = entry.name
        path = entry.pathLower
        switch entry {
            case let fileMetadata as Files.FileMetadata:
                size = fileMetadata.size
                fileType = getFileType(with: path ?? "")
                break
            case _ as Files.FolderMetadata:
                fileType = .folder
                break
            default:
                break
        }
    }
    
    private func getFileType(with path: String) -> FileType {
        let split = path.split(separator: ".")
        guard split.count > 1,
            let fileExtension = split.last else {
                return .folder
        }
        switch fileExtension {
            case "zip", "rar":
                return .compressed
            case "java", "swift":
                return .code
            case "jpg", "png":
                return .image
            case "pdf":
                return .pdf
            default:
                return .unknown
        }
    }
}
