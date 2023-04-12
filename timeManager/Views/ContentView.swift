//
//  ContentView.swift
//  timeManager
//
//  Created by Cedric Frimmel-Hoffmann on 12.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        V_Timer()
            .environmentObject(timerManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
