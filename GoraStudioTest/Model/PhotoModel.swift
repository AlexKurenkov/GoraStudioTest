//
//  PhotoModel.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

// MARK: - API: https://jsonplaceholder.typicode.com

// MARK: - Photo API Model
class Photo: Decodable {
    var albumId      : Int?
    var id           : Int?
    var title        : String?
    var url          : String?
    var thumbnailUrl : String?
}
