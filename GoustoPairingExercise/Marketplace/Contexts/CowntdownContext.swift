import Foundation

protocol CountdownContext {
    func start(countdownTo targetDate: Date,
               update: @escaping (String) -> Void) async
    func stop() async
}

class Countdown: CountdownContext {
    
    private var countDownTask: Task<Void, Never>?
    public let updateInterval: TimeInterval
    private let formatter: DateComponentsFormatter
    private let calender: Calendar
    
    init(updateInterval: TimeInterval = 1.0,
         formatter: DateComponentsFormatter = Countdown.defaultFormatter(),
         calender: Calendar = .current) {
        self.updateInterval = updateInterval
        self.formatter = formatter
        self.calender = calender
    }
    
    static func defaultFormatter() -> DateComponentsFormatter {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.day, .hour, .minute, .second]
        dateFormatter.unitsStyle = .full
        dateFormatter.includesTimeRemainingPhrase = true
        return dateFormatter
    }
    
    
    func start(countdownTo targetDate: Date, update: @escaping (String) -> Void) async {
        
        countDownTask?.cancel()
        
        countDownTask = Task {
            
            do {
                while !Task.isCancelled {
                    
                    let components = calender.dateComponents([.day, .hour, .minute, .second],
                                                             from: Date(),
                                                             to: targetDate)
                    
                    let text = formatter.string(from: components) ?? "invalid"
                    await MainActor.run {
                        update(text)
                    }
                    
                    try await sleepInterval()
                }
            } catch {
                
            }
        }
    }
    
    private func sleepInterval() async throws {
          if #available(iOS 16.0, *) {
              try await Task.sleep(for: .seconds(updateInterval))
          } else {
              try await Task.sleep(nanoseconds: UInt64(updateInterval * 1_000_000_000))
          }
      }
    
    func stop() {
        countDownTask?.cancel()
        countDownTask = nil
    }
}

