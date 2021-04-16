//
//  PublishView.swift
//  test
//
//  Created by 杨宇铎 on 12/3/20.
//

import SwiftUI
import KeychainSwift

struct PublishView: View {
    @EnvironmentObject var appData: AppData
    @State private var text = ""
    @State private var showingAlert = false

    @State private var companyName = ""
    @State private var departmentName = ""
    @State private var groupName = ""
    @State private var positionName = ""
    @State private var contentText = ""
    private let myFontSize:CGFloat = 13
    
    @Binding var popOver: Bool
     
    @State private var selectedProvinceIndex = 0 // 省份城市
    @State private var selectedCityIndex = 0
    
    private let Provinces:Array<String> = ["广东","北京", "上海", "江西", "河南", "黑龙江"]
    let City0 = ["深圳","广州", "中山"]
    let City1 = ["东城区","朝阳区", "海淀区", "通州区"]
    let City2 = ["黄浦区","徐汇区", "静安区", "长宁区", "普陀区"]
    let City3 = ["吉安", "九江"]
    let City4 = ["郑州", "济源"]
    let City5 = ["哈尔滨", "辽宁"]
    // ["黄浦区","徐汇区", "静安区", "长宁区", "普陀区", "虹口区", "杨浦区", "东新区", "闵行区", "宝山区", "嘉定区"]
    
    
    var body: some View {
        let bindingSelectedProvinceIndex = Binding<Int>  (
            get: {selectedProvinceIndex},
            set: {
                selectedProvinceIndex = $0
                selectedCityIndex = 0
            }

        )
        
        return VStack {

            VStack {
                Text("发布您的经验")
                    .font(.title)
                    .padding()

                Text("以下是您在就职的基本信息,请属实填写")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

            }.background(Color.white)
        Form{
        VStack {

            HStack {

                Text("公司:").font(.system(size: myFontSize))
                TextField("公司名称", text: $companyName) .textFieldStyle(RoundedBorderTextFieldStyle())
            }

        }.background(Color.white)
           
            Section(header: Text("省份")) {
                Picker(selection: bindingSelectedProvinceIndex, label: Text("省名")){
                    ForEach (0 ..< Provinces.count) { index in
                        Text(Provinces[index] )
                    }.onTapGesture {
                        selectedCityIndex = 0
                    }

                }.pickerStyle( SegmentedPickerStyle() )
                
                Text("你选择的省份名称: \(Provinces[selectedProvinceIndex])")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 10))
            }

            Section(header: Text("城市")) {
                Picker(selection: $selectedCityIndex, label: Text("城市")){
                     
                    if selectedProvinceIndex == 0 {
                        ForEach (0 ..< City0.count) { index in
                            Text(City0[index] )
                        }
                    } else if selectedProvinceIndex == 1 {
                        ForEach (0 ..< City1.count) { index in
                            Text(City1[index] )
                        }
                    } else if selectedProvinceIndex == 2 {
                        ForEach (0 ..< City2.count) { index in
                            Text(City2[index] )
                        }
                    } else if selectedProvinceIndex == 3 {
                        ForEach (0 ..< City3.count) { index in
                            Text(City3[index] )
                        }
                    } else if selectedProvinceIndex == 4 {
                        ForEach (0 ..< City4.count) { index in
                            Text(City4[index] )
                        }
                    } else if selectedProvinceIndex == 5 {
                        ForEach (0 ..< City5.count) { index in
                            Text(City5[index] )
                        }
                    }
                     

                }.pickerStyle( SegmentedPickerStyle() )
                if selectedProvinceIndex == 0 {
                    Text("你选择的城市名称: \(City0[selectedCityIndex])")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 10))
                } else if selectedProvinceIndex == 1 {
                    Text("你选择的城市名称: \(City1[selectedCityIndex])")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 10))
                } else if selectedProvinceIndex == 2 {
                    Text("你选择的城市名称: \(City2[selectedCityIndex])")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 10))
                } else if selectedProvinceIndex == 3 {
                    Text("你选择的城市名称: \(City3[selectedCityIndex])")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 10))
                } else if selectedProvinceIndex == 4 {
                    Text("你选择的城市名称: \(City4[selectedCityIndex])")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 10))
                } else if selectedProvinceIndex == 5 {
                    Text("你选择的城市名称: \(City5[selectedCityIndex])")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 10))
                }
                    
            }

            Section {
                HStack {

                    Text("部门:").font(.system(size: myFontSize))
                    TextField("部门名称", text: $departmentName) .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack {

                    Text("组名:").font(.system(size: myFontSize))
                    TextField("部门名称", text: $groupName) .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack {

                    Text("职位:").font(.system(size: myFontSize))
                    TextField("职位名称", text: $positionName) .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack {
                    Text("描述:").font(.system(size: myFontSize))
                    TextEditor(text: $contentText)
                        .frame(height: 140)
                        .foregroundColor(Color.gray)
                        .font(.custom("Helvetica Neue", size: 13))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color(red: 200/255, green: 200/255, blue: 200/255))
                        .cornerRadius(5.0)

                }
                Text("注意:严格遵守当地的法律和法规，我们会针对您的内容做审核处理。新app上线不易，谢谢您的支持 email:625306544@qq.com")
                    .font(.footnote)
                    .foregroundColor(.gray)
                   

                }

                Button (action: {
                    print("用户发送文章数据")
                    print(companyName)
                    print(contentText)

                    var publishCityName: String = ""
                    if selectedProvinceIndex == 0 {
                        publishCityName = City0[selectedCityIndex]
             
                    } else if selectedProvinceIndex == 1 {
                        publishCityName = City1[selectedCityIndex]
                   
                    } else if selectedProvinceIndex == 2 {
                        publishCityName = City2[selectedCityIndex]
           
                    } else if selectedProvinceIndex == 3 {
                        publishCityName = City3[selectedCityIndex]
               
                    } else if selectedProvinceIndex == 4 {
                        publishCityName = City4[selectedCityIndex]
                 
                    } else if selectedProvinceIndex == 5 {
                        publishCityName = City5[selectedCityIndex]
                       
                    }
                    
                    let publishText = PublishText(token: appData.CurrentUserInfo.token, companyName: companyName, departmentName: departmentName, groupName: groupName, positionName: positionName, provinceName: self.Provinces[selectedProvinceIndex], cityName: publishCityName, contentText: contentText)
                    
                    NetworkAPI.userPublishSendData(paramters: publishText) { result in
                        switch result {
                        case let .success(list):
                            if list.code == 10000 {
                                self.popOver = false
                                
                            } else {
                                self.text = list.msg
                                self.showingAlert = true
                                
                            }

                        case let .failure(error):
                            self.text = error.localizedDescription
                        }


                    }
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
//                        appData.publishDataInit(restatusInit: false)
//                        
//                    }

                }) {
                    Text("提交")
                        .frame(width: 50, height: 30, alignment: .center)
                        .foregroundColor(Color.blue)
                        .background(Color.blue.opacity(0.1))
                        .shadow(radius: 10 )
                        .padding()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("结果"), message: Text(text), dismissButton: .default(Text("OK")))
                }

            }

        }.background(Color.white)

        


    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView(popOver: .constant(false))
    }
}
