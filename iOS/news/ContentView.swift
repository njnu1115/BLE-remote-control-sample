import SwiftUI
import os

struct ContentView: View {
    var bluetooth = Bluetooth.shared
    @State var change = false;
    @State var presented: Bool = false
    @State var isConnected: Bool = Bluetooth.shared.current != nil { didSet { if isConnected { presented.toggle() } } }
    
    @State private var muleMode: String = "Standby"
    @State private var muleErrorMsg: String = "This is the error message for test purpose"
    @State private var muleBattery: Int8 = 89
    @State private var muleSpeed: Int8 = 5
    @State private var muleSafeSwitch: Bool = false
    
    
    @State var muleSpeedValue:CGFloat = 0
    @State var muleSpeedDifferential:CGFloat = 0
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {  //左半边
                
                Text("Mode: \(muleMode)\nBattery: \(muleBattery)%\nSpeed: \(muleSpeed) mph\n\(muleErrorMsg)")
                //.font(.title)              //设置字体
                    .minimumScaleFactor(0.3)     //字体自适应大小
                //.lineLimit(10)  //限制行数
                //  .background(Color(UIColor(red:103/255,green:231/255,blue:154/255, alpha: 0.1)))         //背景色
                    .foregroundColor(.black)        //字体颜色
                    .lineSpacing(4)                 //行间距
                    .padding(.all, 4)              //外间距
                //  .border(Color.red, width: 5)   //边框
                    .frame(width: 300, height: 120, alignment: .center)     //设置尺寸
                
                Slider(value: $muleSpeedValue, in: 0 ... 100, step: 5){
                    Text("Text")
                } minimumValueLabel: {
                    Text("Speed: 0")
                } maximumValueLabel: {
                    Text("5")
                }
                Text("Speed is \(String(format:"%.2f", 5*muleSpeedValue/100))")
                
                
                Slider(value: $muleSpeedDifferential, in: 0 ... 100, step: 5){
                    Text("muleSpeedDifferential")
                } minimumValueLabel: {
                    Text("0%")
                } maximumValueLabel: {
                    Text("100%")
                }
                Text("Differential is \(String(format:"%.1f", muleSpeedDifferential))")
                
                
                Button(action: {
                }, label: {
                    Image("btn_off")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }).frame(width: 80, height: 80)
                    .background(!muleSafeSwitch ?
                                Color(UIColor.red) :
                                    Color(UIColor.green))
                    .pressAction {
                        muleSafeSwitch = true
                    } onRelease: {
                        muleSafeSwitch = false
                        let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x09] //0x09 means break
                        bluetooth.send(payload)
                    }
                
            }
            
            
            VStack(alignment: .center) { //右半边
                HStack.init(alignment: .center, spacing: 20) {
                    
                    VStack(alignment: .center) { //第一列
                        Button(action: {
                            if(muleSafeSwitch){
                                let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x05]
                                bluetooth.send(payload)
                            }
                        }, label: {
                            Image("btn_315")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x03]
                            bluetooth.send(payload)
                        }, label: {
                            Image("btn_sync_left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x07]
                            bluetooth.send(payload)
                        }, label: {
                            Image("btn_225")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                    }
                    VStack(alignment: .center) { //第二列
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x01]
                            bluetooth.send(payload)
                        }, label: {
                            Image("btn_forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Spacer()
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x02]
                            bluetooth.send(payload)
                        }, label: {
                            Image("btn_backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                    }
                    
                    VStack(alignment: .center) {//第三列
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x06]
                            bluetooth.send(payload)
                        }, label: {
                            Image("btn_45")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x04]
                            bluetooth.send(payload)
                        }, label: {
                            Image("btn_sync_right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }).frame(width: 100, height: 100)
                        Button(action: {
                            let payload : [UInt8] = [UInt8(muleSpeedValue), UInt8(muleSpeedDifferential), 0x08]
                            bluetooth.send(payload)
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
