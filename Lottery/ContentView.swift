//
//  ContentView.swift
//  Lottery
//
//  Created by 褚宣德 on 2023/10/11.
//

import SwiftUI

struct ContentView: View {
    @State private var prizes = ["1獎", "2獎", "3獎", "3獎", "4獎", "4獎", "4獎", "4獎", "4獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎"]
    @State private var selectedPrize: String = ""
    @State private var showFinishMessage = false
    @State private var showingResultAll = false
    @State private var showingResultWin = false
    @State private var showingprobability = false
    @State private var randomNumber = 0
    @State private var count = 0
    
    @State private var resultsAll = [String]()
    @State private var resultsWin = [String]()
  
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    count += 1
                    selectedPrize = randomPrize()
                    if let index = prizes.firstIndex(of: selectedPrize) {
                        prizes.remove(at: index)
                    }
                    
                    let result = "第\(count)抽：\(selectedPrize)"
                    resultsAll.append(result)
                    
                    if selectedPrize != "未中獎" {
                        let resultWin = "第\(count)抽：\(selectedPrize)"
                        resultsWin.append(resultWin)
                    }
                } label: {
                    Text("抽獎")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button {
                    for _ in 0...99 {
                        count += 1
                        selectedPrize = randomPrize()
                        if let index = prizes.firstIndex(of: selectedPrize) {
                            prizes.remove(at: index)
                        }
                        let result = "第\(count)抽：\(selectedPrize)"
                        resultsAll.append(result)
                        
                        if selectedPrize != "未中獎" {
                            let resultWin = "第\(count)抽：\(selectedPrize)"
                            resultsWin.append(resultWin)
                        }
                    }
                } label: {
                    Text("100連抽")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Text("累計抽獎次數： \(count)")
                
                Text(selectedPrize)
                    .font(.title)
                    .padding()
                
                
                Section("目前剩餘獎品數量：\(prizes.count)\n獎項列表：") {
                    List(prizes, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("抽抽樂")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingResultAll = true
                    } label: {
                        Text("抽獎紀錄")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingResultWin = true
                    } label: {
                        Text("中獎紀錄")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        reset()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                        Text("重置抽獎")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingprobability = true
                    } label: {
                        Text("機率")
                    }
                }
                
            }
            .sheet(isPresented: $showingResultAll) {
                VStack {
                    List(resultsAll, id: \.self) {
                        Text($0)
                    }
                }
                .padding()
                .background(.brown)
            }
            .sheet(isPresented: $showingprobability) {
                VStack {
                    Text("1 獎中獎機率為 0.1% \n\n2 獎中獎機率為 2.3%\n\n3 獎中獎機率為 13%\n\n4 獎中獎機率為 18%\n\n5 獎中獎機率為 25%")
                        .font(.title)
                    .foregroundStyle(.white)
                   
                }
                .padding()
                .background(.brown)
            }
            .sheet(isPresented: $showingResultWin) {
                VStack {
                    List(resultsWin, id: \.self) {
                        Text($0)
                    }
                }
                .padding()
                .background(.brown)
            }
            .alert("獎項已全數抽完,是否要重置抽獎？", isPresented: $showFinishMessage) {
                HStack {
                    Button("確定", action: reset)
                    Button("取消",role: .cancel) { }
                }
            } message: {
                Text("恭喜🎉可按取消去觀看抽/中獎紀錄")
            }
        }
    }
    
    func randomPrize() -> String {
        let randomNumber = Int.random(in: 0...999)
        print(randomNumber)
        if prizes.isEmpty {
            showFinishMessage = true
        }
            
            switch randomNumber {
            case 0:
                if prizes.contains("1獎") {
                    return "1獎"
                } else {
                    return "未中獎"
                }
            case 1...23:
                if prizes.contains("2獎") {
                    return "2獎"
                } else {
                    return "未中獎"
                }
            case 24...154:
                if prizes.contains("3獎") {
                    return "3獎"
                } else {
                    return "未中獎"
                }
            case 155...334:
                if prizes.contains("4獎") {
                    return "4獎"
                } else {
                    return "未中獎"
                }
            case 335...584:
                if prizes.contains("5獎") {
                    return "5獎"
                } else {
                    return "未中獎"
                }
            default:
                return "未中獎"
            }       
        
    }

    func reset() {
        prizes = ["1獎", "2獎", "3獎", "3獎", "4獎", "4獎", "4獎", "4獎", "4獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎", "5獎"]
        resultsAll = []
        resultsWin = []
        showFinishMessage = false
        showingResultAll = false
        showingResultWin = false
        randomNumber = 0
        count = 0
    }
}

#Preview {
    ContentView()
}
