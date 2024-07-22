//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Temple on 2024-07-03.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RepoEntry {
        RepoEntry(date: Date(), repo: Repository.placeholder, avatarImageData: Data())
    }

    func getSnapshot(in context: Context, completion: @escaping (RepoEntry) -> ()) {
        let entry = RepoEntry(date: Date(), repo: Repository.placeholder, avatarImageData: Data())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            
            let nextUpdate = Date().addingTimeInterval(43200) //12 hous in seconds
            
            do {
                let repo = try await NetworkManager.shared.getRepo(atURL: RepoURL.swiftNews)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                let entry = RepoEntry(date: .now, repo: repo, avatarImageData: avatarImageData ?? Data())
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                
            } catch {
                print("❌ Error - \(error.localizedDescription)")
                
            }
            
           
        }
    
    }
}

struct RepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let avatarImageData: Data
   
}

struct RepoWatcherWidgetEntryView : View {
    var entry: RepoEntry
    
     
    var body: some View {
        RepoMediumView(repo: entry.repo)
    }
}
     



struct RepoWatcherWidget: Widget {
    let kind: String = "RepoWatcherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                RepoWatcherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RepoWatcherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    RepoWatcherWidget()
} timeline: {
    RepoEntry(date: .now, repo: Repository.placeholder, avatarImageData: Data())
    RepoEntry(date: .now, repo: Repository.placeholder, avatarImageData: Data())
}



