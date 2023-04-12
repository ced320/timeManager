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
        self.time = Time(isBreak: false)
    }
    
    private func reduceRemainingTime(byMinutes minutes: Int) {
        if time.isBreak {
            time.remainingBreakTime -= minutes
        } else {
            time.remainingScreenTime -= minutes
        }
    }
    
    private func checkForSwitch() {
        if time.isBreak && time.remainingBreakTime <= 0 {
            time.isBreak.toggle()
            time.remainingBreakTime = time.breakTime
        } else if !time.isBreak && time.remainingScreenTime <= 0 {
            time.isBreak.toggle()
            time.remainingScreenTime = time.screenTime
        }
    }
    
    func countDownTimer(byMinutes minutes: Int) {
        reduceRemainingTime(byMinutes: minutes)
        checkForSwitch()
    }
    
    
    
}
