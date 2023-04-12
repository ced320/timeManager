//
//  Timer.swift
//  timeManager
//
//  Created by Cedric Frimmel-Hoffmann on 12.04.23.
//

import SwiftUI

struct V_Timer: View {
    
    @EnvironmentObject var timerManager: TimerManager
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("\(timerManager.time.remainingScreenTime)")
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
