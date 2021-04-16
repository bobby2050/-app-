//
//  LoginView.swift
//  MyApp
//
//  Created by 杨宇铎 on 12/2/20.
//

import SwiftUI

import KeychainSwift


struct LoginView: View {
    @EnvironmentObject var appData: AppData
    
    @State private var text = ""
    @State private var showingAlert = false
    @State private var showingLoginSuccessAlert = false
    
    @State private var username = ""
    @State private var password = ""
    
    // 接收外部参数
    @Binding var personalCenterShowSheet: Bool
    @State var loginUserInfo: LoginUserInfo = LoginUserInfo(nickName: "", token: "", user_id: 0)
    @Binding var userState: Int
    @State var error: String = "" // 错误

    @State var lawPageState: Bool = false
    @State var lawPage: Int = 0
    var body: some View {
       
        VStack (alignment: HorizontalAlignment.leading){
            Spacer()
            HStack {
                
                Circle()
                    .fill(Color.blue.opacity(0.5))
                    .frame(width: 30,height: 30)
                    
                    .overlay(
                        Image(systemName: "chevron.forward")
                    )
                    .onTapGesture (count: 1, perform: {
                        personalCenterShowSheet = false
                    })
                    .padding()
                   
                Text("登陆")
                    .font(.title)
            }
            .padding()

            HStack{
                Text("欢迎回来").font(.largeTitle)
            }.frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
             
            
            VStack (alignment: HorizontalAlignment.trailing) {
                HStack {
                    Text("用户名:")
                        .frame(width: UIScreen.main.bounds.width * 0.25, alignment: Alignment.trailing)
                        .font(.subheadline)
                        .padding(0)
                        
                 
                    TextField("用户名", text: $username)
                        .frame(width: UIScreen.main.bounds.width * 0.55)
                        .autocapitalization(.none)
                        .ignoresSafeArea(.keyboard,edges: Edge.Set.bottom)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(3)
                        .padding(0)
                }
            }
            
            VStack(alignment: HorizontalAlignment.leading)  {
                HStack {
                    Text("密码:")
                        .frame(width: UIScreen.main.bounds.width * 0.25, alignment: Alignment.trailing)
                        .font(.subheadline)
                        .padding(0)
                        
                        
                    SecureField("密码", text: $password)
                        .frame(width: UIScreen.main.bounds.width * 0.55)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .ignoresSafeArea(.keyboard,edges: Edge.Set.bottom)
                        .cornerRadius(3)
                        .padding(0)
                        
                }
            }
            

            HStack {
                Spacer()
                Button (action: {
                    print("用户登陆发送数据")
                    let login = Login(name: username, password: password)
                    NetworkAPI.userLoginSendData(paramters: login) { result in
                        switch result {
                        case let .success(list):
                            self.text = list.msg

                            let token = list.data.Token
                            let nickName = list.data.UserInfo.nick_name
                            let myUserId = list.data.UserInfo.id
                            
                            let keychain = KeychainSwift()
                            keychain.set(token, forKey: "myToken")
                            keychain.set(nickName, forKey: "myNickName")
                            keychain.set(String(myUserId), forKey: "myUserId")

                            //  1.登陆后把用户数据写到本地的全局
                            appData.CurrentUserInfo = LoginUserInfo(nickName: nickName, token: token, user_id: myUserId)

                            // 2.登陆后 拉去用户喜欢的文章编号
                            appData.getUserLikePublish()
                            
                            // 3.登陆后 拉去用户关注的编号
                            appData.getUserFocusPublish()
                            
                            // 4.拉去个人的发布列表
                            appData.myPublishList()
                            
                            // 5.看是否用用户登陆，如果不空拉去用户关注的列表
                            if !appData.CurrentUserInfo.token.isEmpty {
                                print("token不空，请求关注列表")
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                    appData.getFocusPublish()
                                }
                            }
                            
                            
                            
//                            let focuspostsParameter = PostsParameter(flag: "normal", token: appData.CurrentUserInfo.token, publishId: 0)
//                            NetworkAPI.FocusPosts(paramters: focuspostsParameter) { result in
//                                switch result {
//                                case let .success(re): self.appData.AppDataHomefocusPosts = re.data;self.appData.sortPost()
//                                case let .failure(error): self.error = error.localizedDescription
//                                }
//                            }
                            
//                            let postsParameter = PostsParameter(flag: "normal", token: appData.CurrentUserInfo.token, publishId: 0)
//                            NetworkAPI.Posts(paramters: postsParameter) { result in
//                                switch result {
//                                case let .success(re): self.appData.Homeposts = re.data
//                                case let .failure(error): self.error = error.localizedDescription
//                                }
//                            }

                            if !appData.CurrentUserInfo.token.isEmpty {
                                self.personalCenterShowSheet = false // 关闭窗口
                            } else {
                                self.showingLoginSuccessAlert = true
                                self.text = "登陆失败"
                            }
                            
                        case let .failure(error):
                            self.text = error.localizedDescription

                        }
                        self.showingAlert = true
                    }

                }) {
                    Text("登陆")
                         
                }
                .alert(isPresented: $showingLoginSuccessAlert) {
                    Alert(title: Text("登陆"), message: Text(text), dismissButton: .default(Text("OK")))
                }.padding()

                Button (action:{
                    userState = 1
                }) {
                    Text("去注册")
                        .underline().font(.subheadline).foregroundColor(.gray)
                }

                Spacer()
            }
        
            Text("感谢您的支持, 有任何问题请给我发邮件625306544@qq.com")
                .frame( width: UIScreen.main.bounds.width,  alignment: .center)
                .foregroundColor(Color.gray)
                .font(.system(size: 13))
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
            Spacer()
             
        }
        .statusBar(hidden: true)
//        .frame(  height: UIScreen.main.bounds.height, alignment: Alignment.topLeading)
        .edgesIgnoringSafeArea(.all)
        .background(Color.orange)
        
    }
}
