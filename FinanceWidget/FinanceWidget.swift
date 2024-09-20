import WidgetKit
import SwiftUI
import SwiftData

//MARK: - Provider
struct Provider: @preconcurrency TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), totalIncome: 0.0, totalExpense: 0.0)
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let finances = getFinances()
        let entry = SimpleEntry(
            date: Date(),
            totalIncome: finances.filter { $0.financeType == .income }.reduce(0) { $0 + $1.amount },
            totalExpense: finances.filter { $0.financeType == .expense }.reduce(0) { $0 + $1.amount }
        )
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let finances = getFinances()
        let entry = SimpleEntry(
            date: Date(),
            totalIncome: finances.filter { $0.financeType == .income }.reduce(0) { $0 + $1.amount },
            totalExpense: finances.filter { $0.financeType == .expense }.reduce(0) { $0 + $1.amount }
        )
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }

    @MainActor private func getFinances() -> [Finance] {
        guard let modelContainer = try? ModelContainer(for: Finance.self) else {
            return []
        }
        let finances = FetchDescriptor<Finance>()
        let financeList = try? modelContainer.mainContext.fetch(finances)
        
        return financeList ?? []
    }
}

// MARK: - SimpleEntry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let totalIncome: Double
    let totalExpense: Double
    
    var total: Double {
        return totalIncome + totalExpense
    }
}

// MARK: - FinanceWidget
struct FinanceWidget: Widget {
    let kind: String = "ButceDostuWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FinanceWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                FinanceWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color(UIColor.systemBackground))
            }
        }
        .configurationDisplayName(NSLocalizedString("WIDGET_DISPLAY_NAME", comment: "Display name for the widget"))
        .description(NSLocalizedString("WIDGET_DESCRIPTION", comment: "Description for the widget"))
    }
}

// MARK: - Preview
#Preview(as: .systemSmall) {
    FinanceWidget()
} timeline: {
    SimpleEntry(date: .now, totalIncome: 0.0, totalExpense: 0.0)
    SimpleEntry(date: .now, totalIncome: 0.0, totalExpense: 0.0)
}

