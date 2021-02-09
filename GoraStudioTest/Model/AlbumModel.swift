//
//  AlbumModel.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

// MARK: - API: https://jsonplaceholder.typicode.com

// MARK: - Album API Model
struct Album: Decodable {
    var userId  : Int?
    var id      : Int?
    var title   : String?
}
