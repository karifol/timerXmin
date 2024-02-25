//
//  ContentView.swift
//  timerXmin
//
//  Created by 堀ノ内海斗 on 2024/02/24.
//

import SwiftUI

struct Time {
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0
}

struct ContentView: View {
    @State var time = Time()
    @State var isShow = false
    var delta = Int.random(in: 1...10)
    
    // Combineで1秒ごとに実行されるタイマーを宣言
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        Text("◯分前の時間が表示される時計")
            .padding()
        Text(String(format: "%02d:%02d:%02d",time.hour, time.minute, time.second))      // HH:mm:ssで表示する
            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 64, weight: .light)))   // 等幅フォントを指定（時刻変化でサイズが変わらないように）
            .onReceive(timer){ _ in
                // タイマー処理で現在時刻に更新
                let now = Date()
                let modified = Calendar.current.date(byAdding: .minute, value: -delta, to: now)!
                self.time.hour = Calendar.current.component(.hour, from: modified)
                self.time.minute = Calendar.current.component(.minute, from: modified)
                self.time.second = Calendar.current.component(.second, from: modified)
            }
        Button(action: {
            isShow = !isShow
        }) {
            if isShow {
                Text("◯分前か隠す")
            } else {
                Text("◯分前か確認する")
            }
        }
            .padding()
        if( isShow ){
            HStack {
                Text("この時計は")
                Text("\(delta)分前")
                    .bold(true)
                    .font(.largeTitle )
                Text("の時間を表示しています")
            }
            Text("◯分前の時間を更新するにはアプリを再起動して下さい")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}




#Preview {
    ContentView()
}
