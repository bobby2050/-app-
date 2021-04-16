//
//  PersonalCenterView.swift
//  test
//
//  Created by 杨宇铎 on 12/13/20.
//

import SwiftUI
import KeychainSwift

struct PersonalCenterView: View {
    
    @EnvironmentObject var appData: AppData
    
    @Binding var personalCenterShowSheet: Bool
    
    @State var myFocus:Bool = false
    @State var myPublish:Bool = false
   
    
    var body: some View {
        
        VStack (alignment: HorizontalAlignment.leading){
             
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
                
                Text("个人中心")
                    .font(.title)
                
            }
            .padding()

            VStack{
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaledToFit()
                    .frame(minWidth:nil,
                            idealWidth: nil,
                            maxWidth: UIScreen.main.bounds.width,
                            minHeight: nil,
                            idealHeight: nil,
                            
                            alignment: .center
                            )
                
                Text("昵称:" + appData.CurrentUserInfo.nickName)
            }

                    
            List{
                
//                Button(action:{
//                    myFocus = true
//                }) {
//                    Text("我的关注")
//                }.sheet(isPresented: $myFocus) {
//                    MyFocusView()
//                }
                
                Button(action:{
                    myPublish = true
                }) {
                    Text("我的发布")
                }.sheet(isPresented: $myPublish) {
                    MyPublishView()
                }
                
                Button(action:{
                    
                }) {
                    Text("设置").strikethrough()
                }
            
                Button (action:{
                    print("点击退出")
                    
                    // 1. 删除keychain
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let keychain = KeychainSwift()
                        keychain.set("", forKey: "myToken")
                        keychain.set("", forKey: "myNickName")
                        keychain.delete("myToken") // Remove single key
                        keychain.delete("myNickName") // Remove single key
                        keychain.clear()
                    }
                    

                    // 2. 删除绑定
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appData.CurrentUserInfo = LoginUserInfo(nickName: "", token: "", user_id: 0)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.personalCenterShowSheet = false // 头像弹出框 关闭
                    }
                    
                    // 推荐列表去掉爱心表示
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appData.cancelMyLikeFocusPublish()
                    }
                    
                    // 用户喜欢文章数据清空
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appData.MyLikePostId = [Int64] ()
                    }
                    
                    // 关注列表数据清空
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appData.HomefocusPublishPosts = [Post]()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appData.myPulishEntity = [MyPulishEntity]()
                    }
                    print("点击退出 - 结束")
                }) {
                    Text("退出")
                }
            }
            
            
            Spacer()
            
        }
    }
}

struct PersonalCenterView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalCenterView(personalCenterShowSheet: .constant(false))
    }
}
