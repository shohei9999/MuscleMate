//
//  Timer.swift
//  MusleMate Watch App
//
//  Created by 林翔平 on 2024/04/10.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager = TimerManager()
    @State private var isTimerStarted = false // タイマーが開始されたかどうかを示すプロパティ
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    // 上段左
                    Image(systemName: "goforward.30")
                        .font(.system(size: 50))
                        .padding()
                        .onTapGesture {
                            timerManager.startTimer(duration: 30)
                            isTimerStarted = true
                        }
                    
                    Spacer()

                    // 上段右
                    Image(systemName: "goforward.60")
                        .font(.system(size: 50))
                        .padding()
                        .onTapGesture {
                            timerManager.startTimer(duration: 60)
                            isTimerStarted = true
                        }
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    // 下段中央
                    Image(systemName: "goforward.90")
                        .font(.system(size: 50))
                        .padding()
                        .onTapGesture {
                            timerManager.startTimer(duration: 90)
                            isTimerStarted = true
                        }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .navigationBarTitle("Timer") // タイトルを変更
            .navigationBarHidden(true) // ナビゲーションバーを非表示にする
            .sheet(isPresented: $isTimerStarted) {
                TimerModalView(timerManager: timerManager)
                    .onDisappear {
                        timerManager.stopTimer()
                    }
            }
        }
    }
}

struct TimerModalView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack {
            Text(timeFormatted(timerManager.remainingTime))
                .font(.system(size: 70, weight: .medium)) // テキストサイズを指定
                .foregroundColor(.yellow)
                .padding()
                .minimumScaleFactor(0.5) // テキストが収まらない場合に自動的に縮小するよう設定
                .lineLimit(1) // テキストがはみ出さないように1行に制限
        }
    }
    
    // 残り時間を00:00形式にフォーマットするメソッド
    private func timeFormatted(_ totalSeconds: TimeInterval) -> String {
        let minutes: Int = Int(totalSeconds) / 60
        let seconds: Int = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView()
}
