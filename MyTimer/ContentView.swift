import SwiftUI

struct ContentView: View {
    @State private var timerHandler: Timer?
    @State private var count = 0
    @State private var showAlert = false
    @AppStorage("timer_value") private var timerValue = 10

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.backgroundTimer)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()

                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)

                    HStack {
                        Button {
                            startTimer()
                        } label: {
                            Text("スタート")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color.start)
                                .clipShape(.circle)
                        }

                        Button {
                            stopTimer()
                        } label: {
                            Text("ストップ")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color.stop)
                                .clipShape(.circle)
                        }
                    }
                }
            }
            .onAppear {
                count = 0
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("秒数設定")
                    }
                }
            }
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                    print("OKがタップされました")
                }
            } message: {
                Text("タイマー終了時間です")
            }
        }
    }

    func startTimer() {
        if let timerHandler {
            if timerHandler.isValid {
                return
            }
        }

        if timerValue - count <= 0 {
            count = 0
        }

        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
        }
    }

    func stopTimer() {
        if let timerHandler {
            if timerHandler.isValid {
                timerHandler.invalidate()
            }
        }
    }

    func countDownTimer() {
        count += 1

        if timerValue - count <= 0 {
            timerHandler?.invalidate()

            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
