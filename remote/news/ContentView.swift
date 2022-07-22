import SwiftUI
import os

struct ContentView: View {
    var bluetooth = Bluetooth.shared
    @State var change = false;
    @State var presented: Bool = false
    @State var isConnected: Bool = Bluetooth.shared.current != nil { didSet { if isConnected { presented.toggle() } } }
    
    var body: some View {
        VStack(alignment: .center) {
            if isConnected {            }
            
            Button(action: {
                bluetooth.send([0x0046]) //UTF-8 code for "F"
                      }, label: {
                          Image("btn_forward")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
            
            HStack.init(alignment: .center, spacing: 100) {
                Button(action: {
                bluetooth.send([0x004C])  //UTF-8 code for "F"
                      }, label: {
                          Image("btn_left")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
                Button(action: {
                bluetooth.send([0x0052])  //UTF-8 code for "F"
                      }, label: {
                          Image("btn_right")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                      }).frame(width: 100, height: 100)
            }
            Button(action: {
            bluetooth.send([0x0042])  //UTF-8 code for "F"
                  }, label: {
                      Image("btn_backward")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  }).frame(width: 100, height: 100)
            
            
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
