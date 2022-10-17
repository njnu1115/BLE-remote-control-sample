import SwiftUI
import os

struct ContentView: View {
    var bluetooth = Bluetooth.shared
    @State var change = false;
    @State var presented: Bool = false
    @State var isConnected: Bool = Bluetooth.shared.current != nil { didSet { if isConnected { presented.toggle() } } }
    
    @State private var gear = 0
    @State private var mode: String = "Standby"
    @State private var battery: Int8 = 89
    @State private var speed: Int8 = 5

    @State var speedValueLeft:CGFloat = 0
    @State var speedValueRight:CGFloat = 0

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                
                Text("Mode: \(mode)\nBattery: \(battery)%\nSpeed: \(speed) mph")
                    .font(.title)              //设置字体
                    .minimumScaleFactor(0.5)     //字体自适应大小
                //.lineLimit(10)  //限制行数
                    .background(Color.yellow)         //背景色
                    .foregroundColor(.black)        //字体颜色
                    .lineSpacing(8)                 //行间距
                    .padding(.all, 10)              //外间距
                    .border(Color.red, width: 5)   //边框
                    .frame(width: 300, height: 200, alignment: .center)     //设置尺寸
                
                Button(action: {
                    bluetooth.send([0 == gear ? 0x0042 : 0x0043])
                }, label: {
                    Image("btn_power")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }).frame(width: 100, height: 100)
            }
            
            VStack(alignment: .center) {
                Slider(value: $speedValueLeft, in: 0 ... 100, label: {
                    Text("aValue")
                })
                HStack.init(alignment: .center, spacing: 20) {
                    Button(action: {
                        bluetooth.send([0 == gear ? 0x0042 : 0x0043])
                    }, label: {
                        Image("btn_left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }).frame(width: 100, height: 100)
                    VStack(alignment: .center) {
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                    }
                    
                    Button(action: {
                        bluetooth.send([0 == gear ? 0x0046 : 0x0047])
                    }, label: {
                        Image("btn_right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }).frame(width: 100, height: 100)
                }
            }
        }.onAppear{
            os_log(" onAppear, init bluetooth ")
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }.onDisappear{
            os_log(" onDisappear, stop bluetooth scan ")
            bluetooth.stopScanning()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
