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
        RepoEntry(date: Date(), repo: Repository.placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (RepoEntry) -> ()) {
        let entry = RepoEntry(date: Date(), repo: Repository.placeholder)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            
            let nextUpdate = Date().addingTimeInterval(43200) //12 hous in seconds
            
            do {
                var repo = try await NetworkManager.shared.getRepo(atURL: RepoURL.swiftNews)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                let entry = RepoEntry(date: .now, repo: repo)
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
   
   
}

struct RepoWatcherWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family
    var entry: RepoEntry
    
    
    var body: some View {
        
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            
            VStack(spacing: 36) {
                RepoMediumView(repo: entry.repo)
                RepoMediumView(repo: entry.repo)
             }
            
            
        case .systemSmall, .systemExtraLarge, .accessoryCircular,
                .accessoryRectangular,
                .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
            
        }
          
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
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

#Preview(as: .systemLarge) {
    RepoWatcherWidget()
} timeline: {
    RepoEntry(date: .now, repo: Repository.placeholder)
    RepoEntry(date: .now, repo: Repository.placeholder)
}



