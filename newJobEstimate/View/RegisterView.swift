//
//  ContentView.swift
//  MyApp
//
//  Created by 杨宇铎 on 11/24/20.
//

import SwiftUI


struct RegisterView: View {
    
    @State private var text = ""
    @State private var showingAlert = false
    
    @State private var username = ""
    @State private var password = ""
    @State private var repassword = ""
    @State private var nickname = ""
    @State private var email = ""
    @State private var city = ""
    
    // 接收外部参数
    @Binding var personalCenterShowSheet: Bool
    @Binding var userState: Int
    
    @State var lawPageState: Bool = false
    @State var lawPage: Int = 0
    var body: some View {
        VStack (alignment: HorizontalAlignment.leading) {
            HStack {

                Circle()
                    .fill(Color.blue.opacity(0.5))
                    .frame(width: 30,height: 30)
                    .overlay(
                        Image(systemName: "chevron.forward")
                    ).onTapGesture (count: 1, perform: {
                        personalCenterShowSheet = false
                    })
                    .padding()
                
                Text("注册")
                    .font(.title)
                
                 
                
                
            }
            .padding()
            
            HStack{
                Text("欢迎你的加入").font(.largeTitle)
            }
            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
             
            
            VStack{
                
                VStack{
                    
                    HStack  {
                        Text("用户名:").font(.subheadline)
                            .frame(width: UIScreen.main.bounds.width * 0.16, alignment: Alignment.trailing)
                        
                        TextField("用户名", text: $username)
                            .frame(width: UIScreen.main.bounds.width * 0.55)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack  {
                        Text("密码:").font(.subheadline).frame(width: UIScreen.main.bounds.width * 0.16, alignment: Alignment.trailing)
                        SecureField("密码", text: $password)  .frame(width: UIScreen.main.bounds.width * 0.55).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack  {
                        Text("重复密码:").font(.subheadline).frame(width: UIScreen.main.bounds.width * 0.16, alignment: Alignment.trailing)
                        SecureField("重复密码", text: $repassword)  .frame(width: UIScreen.main.bounds.width * 0.55).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack  {
                        Text("昵称:").font(.subheadline).frame(width: UIScreen.main.bounds.width * 0.16, alignment: Alignment.trailing)
                        TextField("昵称", text: $nickname) .frame(width: UIScreen.main.bounds.width * 0.55).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack  {
                        Text("邮箱:").font(.subheadline).frame(width: UIScreen.main.bounds.width * 0.16, alignment: Alignment.trailing)
                        
                        TextField("邮箱", text: $email)
                            .frame(width: UIScreen.main.bounds.width * 0.55)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    
                }
                
                HStack {
                    
                    Button (action: {
                        print("用户注册发送数据")
                        
                        let register = Register(username: username, password: password, re_password: repassword, nick_name: nickname, email: email)

                        NetworkAPI.userRegisterSendData(paramters: register) { result in
                            switch result {
                            case let .success(list):
                                self.text = list.msg

                            case let .failure(error):
                                self.text = error.localizedDescription
                            }
                            self.showingAlert = true
                            userState = 0
                        }
                             
                    }) {
                        Text("确认注册")
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("结果"), message: Text(text), dismissButton: .default(Text("OK")))
                    }
                    
                    Button (action:{
                        userState = 0
                    }) {
                        Text("去登陆").underline().font(.subheadline).foregroundColor(.gray)
                    }
                }.padding()
                
                Text("感谢您的支持, 有任何问题请给我发邮件625306544@qq.com")
                    .foregroundColor(Color.gray)
                    .font(.system(size:13))
                    .padding()
                 
                HStack{
                    
                    Text("注册或登录即代表已阅读并同意")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white)
                    
                    
                    Text("产品使用许可协议")
                        .font(.system(size: 12))
                        .foregroundColor(Color.blue)
                        .foregroundColor(Color.white)
                        .onTapGesture {
                            lawPage = 1
                            lawPageState = true
                        }
                    
                    Text("及")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white)
                    

                    Text("隐私保护指引")
                        .font(.system(size: 12))
                        .foregroundColor(Color.blue)
                        .foregroundColor(Color.white)
                        .onTapGesture {
                            lawPage = 2
                            lawPageState = true
                            
                        }
                     
                }
                .frame( width: UIScreen.main.bounds.width,  alignment: .center)
                .padding()
                .sheet(isPresented: $lawPageState) {
                    if lawPage == 1 {
                        LowProView(name: "产品使用许可协议", myUrl: "https://www.bestjan.com/agreement.html")
                    } else if lawPage == 2 {
                        LowProView(name: "隐私保护指引", myUrl: "https://www.bestjan.com/protect.html")
                    }
                }
     
            
            }
            
        }
        .frame(  height: UIScreen.main.bounds.height, alignment: Alignment.topLeading)
        .edgesIgnoringSafeArea(.vertical)
        .background(Color.orange)
        
        
    }

}
