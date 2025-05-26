//
//  DashboardViewModel.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

import UIKit

protocol DashboardViewModeling {
    var onCountdownUpdate: ((String) -> Void)? { get set }
    
    func startCountdown()
    func stopCountdown()
}

final class DashboardViewModel: DashboardViewModeling {
    
    private let context: CountdownContext
    private let calender: Calendar
    
    var onCountdownUpdate: ((String) -> Void)?
    
    init(context: CountdownContext,
         calender: Calendar = .current) {
        self.context = context
        self.calender = calender
    }
    
    func startCountdown() {
        
        Task {
            
            guard let nextReleaseDate = Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 12, weekday: 3), matchingPolicy: .nextTime) else {
                
                fatalError("Unable to determine the next release date")
            }
            
            await context.start(countdownTo: nextReleaseDate) { [weak self] text in
                self?.onCountdownUpdate?(text)
            }
        }
    }
    
    func stopCountdown() {
        Task { await context.stop() }
    }
}
