import SwiftUI
import os

struct ContentView: View {
    var bluetooth = Bluetooth.shared
    @State var change = false;
    @State var presented: Bool = false
    @State var isConnected: Bool = Bluetooth.shared.current != nil { didSet { if isConnected { presented.toggle() } } }
// isConnected 的判断在这里似乎不工作， 现在还不知道怎么在isConnected的时候下钩子来更新这里的UI控件，TBD

    var body: some View {
        VStack(alignment: .center) {
            HStack{
//                Text("Bluetooth is \(isConnected ? "Available":"Unavailable")")
//                Image(systemName: isConnected ? "checkmark":"xmark")
//                    .foregroundColor(isConnected ?  .green:.red)
            }.font(.largeTitle)
            
            HStack.init(alignment: .center, spacing: 0){
                
/// todo: 把这个按钮换成一个像是车上仪表盘显示档位切换D档的那种样式
            Button(action: {
                bluetooth.send([0x0044]) //UTF-8 code for "D"
                      }, label: {
                          Image("btn_forward")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
/// todo: 把这个按钮换成一个像是车上仪表盘显示档位切换R档的那种样式
            Button(action: {
                bluetooth.send([0x0052]) //UTF-8 code for "R"
                      }, label: {
                          Image("btn_backward")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
            }.font(.largeTitle)
            HStack.init(alignment: .center, spacing: 20) {
                Button(action: {
                bluetooth.send([0x004C])  //UTF-8 code for "L"
                      }, label: {
                          Image("btn_left")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
                Button(action: {
                bluetooth.send([0x0046])  //UTF-8 code for "F"
                      }, label: {
                          Image("btn_forward")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
                Button(action: {
                bluetooth.send([0x0052])  //UTF-8 code for "R"
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
