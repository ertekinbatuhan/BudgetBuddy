import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
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
        
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*5)))
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let totalIncome: Double
    let totalExpense: Double
    
    var total: Double {
        return totalIncome + totalExpense
    }
}

struct FinanceWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            VStack {
                Text("Toplam")
                    .font(.headline)
                Text("\(entry.total, format: .currency(code: "TRY"))")
                    .font(.largeTitle)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            
            HStack {
                HStack {
                    Image(systemName: "arrow.up.circle.fill") // Gelir ikonu
                        .foregroundColor(.green)
                    VStack(alignment: .leading) {
                        Text("Gelir")
                            .font(.headline)
                        Text("\(entry.totalIncome, format: .currency(code: "TRY"))")
                            .font(.title2)
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "arrow.down.circle.fill") // Gider ikonu
                        .foregroundColor(.red)
                    VStack(alignment: .leading) {
                        Text("Gider")
                            .font(.headline)
                        Text("\(entry.totalExpense, format: .currency(code: "TRY"))")
                            .font(.title2)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct FinanceWidget: Widget {
    let kind: String = "FinanceWidget"

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
        .configurationDisplayName("Finance Tracker Widget")
        .description("Shows total income and expenses.")
    }
}

#Preview(as: .systemSmall) {
    FinanceWidget()
} timeline: {
    SimpleEntry(date: .now, totalIncome: 0.0, totalExpense: 0.0)
    SimpleEntry(date: .now, totalIncome: 0.0, totalExpense: 0.0)
}

