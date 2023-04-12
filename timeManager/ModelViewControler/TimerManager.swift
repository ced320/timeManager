//
//  timerManager.swift
//  timeManager
//
//  Created by Cedric Frimmel-Hoffmann on 12.04.23.
//

import SwiftUI

class TimerManager: ObservableObject {
    @Published var time: Time
    
    init() {
        self.time = Time(state: .beforeWorking)
    }
    

    private func reduceRemainingTime(byMinutes minutes: Int) {
        switch time.state {
        case .inBreak:
            time.remainingBreakTime -= minutes
        case .working:
            time.remainingScreenTime -= minutes
        default:
            break
        }
    }
    
    
    private func checkForSwitch() {
        switch time.state {
        case .inBreak:
            if time.remainingBreakTime <= 0 {
                time.remainingBreakTime = time.breakTime
                time.state = .beforeWorking
            }
        case .working:
            if time.remainingScreenTime <= 0 {
                time.remainingScreenTime = time.screenTime
                time.state = .inBreak
            }
        default:
            break
        }
    }
    
    func countDownTimer(byMinutes minutes: Int) {
        reduceRemainingTime(byMinutes: minutes)
        checkForSwitch()
    }
    
    
    
}
