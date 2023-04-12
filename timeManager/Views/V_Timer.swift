//
//  Timer.swift
//  timeManager
//
//  Created by Cedric Frimmel-Hoffmann on 12.04.23.
//

import SwiftUI

struct V_Timer: View {
    
    @EnvironmentObject var timerManager: TimerManager
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @ViewBuilder
    var body: some View {
        timerManager.time.isBreak ? AnyView(breakTimeRemainingView) : AnyView(screenTimeRemainingView)
    }
    
    var screenTimeRemainingView: some View {
        VStack {
            Text("Currently working")
            Text("\(timerManager.time.remainingScreenTime)")
                .onReceive(timer) { time in
                    timerManager.countDownTimer(byMinutes: 1)
                }
        }
    }
    
    var breakTimeRemainingView: some View {
        VStack {
            Text("Make a break for: ")
            Text("\(timerManager.time.remainingBreakTime)")
                .onReceive(timer) { time in
                    timerManager.countDownTimer(byMinutes: 1)
                }
        }
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        V_Timer()
    }
}
