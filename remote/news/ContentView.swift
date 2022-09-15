import SwiftUI
import os

struct ContentView: View {
    var bluetooth = Bluetooth.shared
    @State var change = false;
    @State var presented: Bool = false
    @State var isConnected: Bool = Bluetooth.shared.current != nil { didSet { if isConnected { presented.toggle() } } }
// isConnected 的判断在这里似乎不工作， 现在还不知道怎么在isConnected的时候下钩子来更新这里的UI控件，TBD
    @State private var gear = 0

    var body: some View {
        

        
        VStack(alignment: .center) {
            Picker("Select Gear", selection: $gear) {
                Text("D")
                    .tag(0)
                Text("R")
                    .tag(1)
            }
            .pickerStyle(.segmented)
            
            HStack.init(alignment: .center, spacing: 20) {
                Button(action: {
                bluetooth.send([0 == gear ? 0x0042 : 0x0043]) //42:LeftForward, 43:LeftReverse
                      }, label: {
                          Image("btn_left")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
                Button(action: {
                    bluetooth.send([0 == gear ? 0x0044 : 0x0045]) //44: Forward, 45:Reverse
                      }, label: {
                          Image(0 == gear ? "btn_forward" : "btn_backward")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
                Button(action: {
                    bluetooth.send([0 == gear ? 0x0046 : 0x0047]) // 46: RightForward, 47:RightReverse
                      }, label: {
                          Image("btn_right")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)

            }

            
        }.onAppear{
            os_log(" onAppear, init bluetooth ")
        }.onDisappear{
            os_log(" onDisappear, stop bluetooth scan ")
            bluetooth.stopScanning() }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
