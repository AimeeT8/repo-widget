//
//  Repository.swift
//  RepoWatcher
//
//  Created by Temple on 2024-07-03.
//

import SwiftUI


struct Repository: Decodable {
    
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String 
    
    static let placeholder = Repository(
        name: "Your Repo",
        owner: Owner(avatarUrl: ""),
        hasIssues: true,
        forks: 91,
        watchers: 123,
        openIssues: 65,
        pushedAt: "2024-06-29T12:55:05Z"
    )
    
    
}



struct Owner: Decodable {
    let avatarUrl: String
    
    
}
