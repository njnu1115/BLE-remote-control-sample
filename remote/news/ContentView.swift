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
            
            Button("Move Forward") {
                bluetooth.send([0x0046]) //UTF-8 code for "F"
            }
            .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
            .border(Color.purple, width: 5)
            
            HStack {
                Button("Move Left") {
                    bluetooth.send([0x004C]) //UTF-8 code for "L"
                }
                .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                .border(Color.purple, width: 5)
            
                Button("Move Right") {
                    bluetooth.send([0x0052]) //UTF-8 code for "R"
                }
                .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                .border(Color.purple, width: 5)
            }
            Button("Move Backward") {
                bluetooth.send([0x0042]) //UTF-8 code for "B"
            }
            .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
            .border(Color.purple, width: 5)
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
