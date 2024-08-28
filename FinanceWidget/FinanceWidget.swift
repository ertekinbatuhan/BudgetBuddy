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
        VStack(alignment: .leading) {
            VStack {
                Text("Toplam")
                    .font(.headline)
                Text("\(entry.total, format: .currency(code: "TRY"))")
                    .font(.largeTitle)
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.tail) 
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            
            HStack {
                VStack {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(.green)
                    Text("Gelir")
                        .font(.headline)
                    Text("\(entry.totalIncome, format: .currency(code: "TRY"))")
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                VStack {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundColor(.red)
                    Text("Gider")
                        .font(.headline)
                    Text("\(entry.totalExpense, format: .currency(code: "TRY"))")
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct FinanceWidget: Widget {
    let kind: String = "BütçeDostuWidget"

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
        .configurationDisplayName("BütçeDostu Widget")
        .description("Toplam gelir ve giderleri gösterir.")
    }
}

#Preview(as: .systemSmall) {
    FinanceWidget()
} timeline: {
    SimpleEntry(date: .now, totalIncome: 0.0, totalExpense: 0.0)
    SimpleEntry(date: .now, totalIncome: 0.0, totalExpense: 0.0)
}

