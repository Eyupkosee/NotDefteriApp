//
//  StatisticsView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 8.03.2025.
//

import SwiftUI
import DGCharts
import Charts

struct StatisticsView: View {
    @ObservedObject var statisticsViewModel = StatisticsViewModel()
    @ObservedObject var todoViewModel: TodoViewModel

    var body: some View {
        ZStack {
            // Arka Plan
            BackgroundTheme()

            VStack(spacing: 20) {
                Text("İstatistiklerim")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("textViewColor"))
                    .italic()
                    .padding(.top, 10)

                CustomPieChartView(entries: statisticsViewModel.taskStatistics, title: "Görev Durumu")
                    .frame(height: 300)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)

                HStack(spacing: 20) {
                    InfoCard(title: "Toplam Görev", value: "\(statisticsViewModel.totalTasks)")
                    InfoCard(title: "Tamamlanan", value: "\(statisticsViewModel.completedTasks)")
                    InfoCard(title: "Bekleyen", value: "\(statisticsViewModel.pendingTasks)")
                }
                .padding(.horizontal)

                Spacer()
            }
            .onAppear {
                statisticsViewModel.calculateStatistics(tasks: todoViewModel.tasks)
            }
        }
    }
}

struct CustomPieChartView: UIViewRepresentable {
    var entries: [PieChartDataEntry]
    var title: String

    typealias UIViewType = DGCharts.PieChartView

    func makeUIView(context: Context) -> DGCharts.PieChartView {
        let chart = DGCharts.PieChartView()
        chart.chartDescription.text = title
        chart.holeRadiusPercent = 0.5
        chart.holeColor = .white.withAlphaComponent(0.2)
        return chart
    }

    func updateUIView(_ uiView: DGCharts.PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = [UIColor.systemGreen, UIColor.systemOrange, UIColor.systemRed]
        dataSet.valueTextColor = .black
        dataSet.valueFont = .boldSystemFont(ofSize: 14)

        let data = PieChartData(dataSet: dataSet)
        uiView.data = data
    }
}



#Preview {
    StatisticsView(todoViewModel: TodoViewModel())
}

