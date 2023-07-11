//
//  ReposModel.swift
//  GitUsers
//
//  Created by A.Stelmakh on 7.07.2023.
//

import Foundation

class ReposModel: Identifiable ,Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var url: String?
    var language: String?
    var archived: Bool?
}
