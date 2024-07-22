//
//  Repository.swift
//  RepoWatcher
//
//  Created by Temple on 2024-07-03.
//

import SwiftUI


struct Repository {
    
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    var avatarData: Data
    
    static let placeholder = Repository(
        name: "Your Repo",
        owner: Owner(avatarUrl: ""),
        hasIssues: true,
        forks: 91,
        watchers: 123,
        openIssues: 65,
        pushedAt: "2024-06-29T12:55:05Z",
        avatarData: Data())
}

extension Repository {
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let hasIssues: Bool
        let forks: Int
        let watchers: Int
        let openIssues: Int
        let pushedAt: String
        
    
        var repo: Repository {
            Repository(name: name, owner: owner, hasIssues: hasIssues, forks: forks, watchers: watchers, openIssues: openIssues, pushedAt: pushedAt, avatarData: Data())
        }
        
    }
    
}



struct Owner: Decodable {
    let avatarUrl: String
    
    
}












































