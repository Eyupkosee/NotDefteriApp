//
//  StatisticsViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 8.03.2025.
//

import Foundation
import Charts
import DGCharts

class StatisticsViewModel: ObservableObject {
    @Published var completedTasks: Int = 0
    @Published var pendingTasks: Int = 0
    @Published var totalTasks: Int = 0
    @Published var errorMessage: String = ""
    
    var taskStatistics: [PieChartDataEntry] {
        [
            PieChartDataEntry(value: Double(completedTasks), label: "Tamamlanan"),
            PieChartDataEntry(value: Double(pendingTasks), label: "Tamamlanmayan")
        ]
    }

    func calculateStatistics(tasks: [Task]) {
        completedTasks = tasks.filter { $0.isDone }.count
        pendingTasks = tasks.count - completedTasks
        totalTasks = tasks.count
    }
}

