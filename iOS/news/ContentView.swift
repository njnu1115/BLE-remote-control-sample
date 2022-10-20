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
            VStack(alignment: .center) {  //左半边
                
                Text("Mode: \(mode)\nBattery: \(battery)%\nSpeed: \(speed) mph")
                //.font(.title)              //设置字体
                    .minimumScaleFactor(0.5)     //字体自适应大小
                //.lineLimit(10)  //限制行数
                //  .background(Color(UIColor(red:103/255,green:231/255,blue:154/255, alpha: 0.1)))         //背景色
                    .foregroundColor(.black)        //字体颜色
                    .lineSpacing(8)                 //行间距
                    .padding(.all, 10)              //外间距
                //  .border(Color.red, width: 5)   //边框
                    .frame(width: 300, height: 200, alignment: .center)     //设置尺寸
                
                Slider(value: $speedValueLeft, in: 0 ... 100, step: 5){
                    Text("Speed")
                } minimumValueLabel: {
                    Text("Speed: 0")
                } maximumValueLabel: {
                    Text("5")
                }
                
                Slider(value: $speedValueRight, in: 0 ... 100, step: 5){
                    Text("Speed")
                } minimumValueLabel: {
                    Text("0%")
                } maximumValueLabel: {
                    Text("100%")
                }
                Button(action: {
                    bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                }, label: {
                    Image("btn_off")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }).frame(width: 100, height: 100)

            }
            
            
            VStack(alignment: .center) { //右半边
                HStack.init(alignment: .center, spacing: 20) {
                    
                    VStack(alignment: .center) { //第一列
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_315")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_sync")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_225")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                    }
                    VStack(alignment: .center) { //第二列
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Spacer()
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                    }
                    
                    VStack(alignment: .center) {//第三列
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_45")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_sync")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        Button(action: {
                            bluetooth.send([0 == gear ? 0x0044 : 0x0045])
                        }, label: {
                            Image("btn_135")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                    }
                    
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
