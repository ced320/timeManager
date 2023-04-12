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
    let window = NSApplication.shared.windows.last
    
    
    @ViewBuilder
    var body: some View {
        switch timerManager.time.state {
        case .beforeWorking:
            startNextRoundView
        case .inBreak:
            breakTimeRemainingView
                .onAppear() {
                        window?.deminiaturize(nil)
                }
        case .working:
            screenTimeRemainingView
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            window?.miniaturize(nil)
                    }
                }
        }
    }
    
    var screenTimeRemainingView: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("Currently working")
                Text("\(timerManager.time.remainingScreenTime)")
                    .onReceive(timer) { time in
                        timerManager.countDownTimer(byMinutes: 1)
                    }
            }
        }
    }
    
    var breakTimeRemainingView: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            VStack {
                Text("Make a break for: ")
                Text("\(timerManager.time.remainingBreakTime)")
                    .onReceive(timer) { time in
                        timerManager.countDownTimer(byMinutes: 1)
                    }
            }
        }
    }
    
    var startNextRoundView: some View {
        VStack {
            Spacer()
            Text("Screen Timer")
                .font(.title)
            Spacer()
            Image(systemName: "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .foregroundColor(.cyan)
                .onTapGesture {
                    withAnimation {
                        timerManager.time.state = .working
                    }
                }
            Spacer()
            Text("Press button to start working")
                .font(.footnote)
            Spacer()
        }.padding()
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        V_Timer()
    }
}
