//
//  URLManager.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import Foundation

class URLManager {
    static let shared = URLManager(); private init() { }
    
    private let tunnel = "https://"
    private let server = "api.github.com"
    
    func createURL(user: String, repos: String) -> URL? {
        let str = tunnel + server + EndPoint.users.rawValue
        var strUrl = ""
        
        if user.isEmpty {
            print("user list url")
            return URL(string: str)
        } else if repos.isEmpty{
            print("user url")
             strUrl = str + "/" + user
        } else {
            print("repos url")
             strUrl = str + "/" + user + "/" + repos
        }
        return URL(string: strUrl)
    }
}

enum EndPoint: String {
    case users = "/users"
}
