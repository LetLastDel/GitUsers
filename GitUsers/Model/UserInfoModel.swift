//
//  UserInfoModel.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import Foundation


class UserInfoModel: Identifiable, Decodable {
    var id: Int
    var avatarUrl: String?
    var company: String?
    var location: String?
    var login: String
    var name: String?
    var reposUrl: String?
    var email: String?
}
private enum CodingKeys: String, CodingKey {
    case id, avatarUrl = "avatar_url", company, location, login, name, reposUrl = "repos_url", email
}
