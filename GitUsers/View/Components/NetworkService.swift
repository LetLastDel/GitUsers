//
//  NetworkService.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import Foundation
import UIKit

class NetworkService {
    
    static let shared = NetworkService(); private init() { }
    
    func getUs<T: Decodable>(user: String, repos: String) async throws -> [T] {
        guard let url = URLManager.shared.createURL(user: user, repos: repos) else { throw NetworkError.badUrl }
        print(url)
        do{
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                if let userData = try? decoder.decode(T.self, from: data){
                    print("array")
                    return [userData]
                } else if let user = try? decoder.decode([T].self, from: data){
                    print("value")
                    return user
                } else {
                    print("invalid decoding")
                    throw NetworkError.invalidDecoding
                }
            } catch {
                throw NetworkError.invalidDecoding
            }
        }
    }
    func downloadImageData(url: String) async throws -> Data {
        guard let url = URL(string: url) else { throw NetworkError.badUrl}
        let responce = try await URLSession.shared.data(from: url)
        let data = responce.0
        return data
    }
}

enum NetworkError: Error {
    case badUrl
    case badResponse
    case invalidDecoding
    case invalidImageData
}
