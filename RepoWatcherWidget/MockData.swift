//
//  MockData.swift
//  RepoWatcher
//
//  Created by Aimee Temple on 2024-07-22.
//

import Foundation


struct MockData {
    
    
    static let repoOne = Repository(
        name: "Repository 1",
        owner: Owner(avatarUrl: ""),
        hasIssues: true,
        forks: 91,
        watchers: 123,
        openIssues: 65,
        pushedAt: "2024-06-29T12:55:05Z",
        avatarData: Data())
    
    
    
    static let repoTwo = Repository(
        name: "Repository 2",
        owner: Owner(avatarUrl: ""),
        hasIssues: false,
        forks: 155,
        watchers: 976,
        openIssues: 120,
        pushedAt: "2024-01-29T12:55:05Z",
        avatarData: Data())
    
    
    
}
