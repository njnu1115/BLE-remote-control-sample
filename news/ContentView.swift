import SwiftUI


struct ContentView: View {
    var bluetooth = Bluetooth.shared
    @State var change = false;
    @State var presented: Bool = false
    @State var isConnected: Bool = Bluetooth.shared.current != nil { didSet { if isConnected { presented.toggle() } } }
    
    var body: some View {
        VStack(alignment: .center) {
            if isConnected {            }
            
            Button("Move Forward") {
                    self.change.toggle()
                }.padding()
            
            HStack {
                Button("Move Left") {
                    self.change.toggle()
                }.padding()
            
                Button("Move Right") {
                    self.change.toggle()
                }.padding()
            }
            Button("Move Backward") {
                self.change.toggle()
            }.padding()
        }.onAppear{
            bluetooth.startScanning()
        }.onDisappear{ bluetooth.stopScanning() }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// 如果我想在App启动之后做BLE的scan，应该把代码放在这里，还是放在别的地方呢？
// 如果放在这里的话，在以前UIKit的时候，是有ViewController.viewDidLoad(){}这个地方可以放置，那如今SwiftUI有对应的地方么？