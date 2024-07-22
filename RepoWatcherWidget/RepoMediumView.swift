//
//  RepoMediumView.swift
//  RepoWatcher
//
//  Created by Aimee Temple on 2024-07-22.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    let formatter = ISO8601DateFormatter()
    var daysSinceLastActivity: Int {
        calculateDaysinceLastActivity(from: repo.pushedAt)
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    
                    
                    Image(uiImage: UIImage(named: "avatar")!)
                        .resizable()
                        .frame(width: 50, height: 50 )
                        .clipShape(Circle())
                    
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    
                }
                .padding(.bottom, 6)
                
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value:  repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
               
            }
            Spacer()
            
            VStack {
                Text("\(daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundColor(daysSinceLastActivity > 50 ? .pink : .green)
                
                Text("Days ago")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
            
        }
    
    func calculateDaysinceLastActivity(from dateString: String) -> Int {
        
        
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        
        return daysSinceLastActivity
    }
  
}

#Preview(){
    RepoMediumView(repo: Repository.placeholder)
        .previewContext(WidgetPreviewContext(family: .systemMedium))
}

fileprivate struct StatLabel: View {
    
    let value: Int
    let systemImageName: String
    
    
    var body: some View {
        
        Label {
            Text("\(value)")
                .font(.footnote)
        } icon: {
            Image(systemName: systemImageName)
                .foregroundColor(.green)
        }
        .fontWeight(.medium)
        
    }
}