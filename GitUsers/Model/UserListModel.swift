//
//  UserListModel.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import Foundation


class UserListModel: Identifiable, Decodable {
    
    var login: String
    var id: Int
    var avatarUrl: String
    var url: String
    
}
private enum CodingKeys: String, CodingKey {
       case login, id, avatarUrl = "avatar_url", url
   }
