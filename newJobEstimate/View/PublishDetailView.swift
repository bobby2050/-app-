//
//  PublishDetailView.swift
//  test
//
//  Created by 杨宇铎 on 12/4/20.
//

import SwiftUI

struct PublishDetailView: View {
    @EnvironmentObject var appData: AppData
    var chekedPost: Post
//    @Binding var personalCenterShowSheet: Bool
//    @Binding var chekedStatus: Bool
//    @Binding var showPublishSheet: Bool
    
    @State var replyData: [ReplyData] = [ReplyData]()

    
    // 举报
    @State var isActionSheet:Bool = false
    @State var isActionSheetPostId:Int64 = 0
    
    var body: some View {
        VStack {
             
                
            
                VStack {
                    
               
                    HStack {
                        Text("作者: \(chekedPost.nick_name)")
                            .frame(width: UIScreen.main.bounds.width, height: 35)
                            .background(Color.blue)
                    }
                     
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                        ScrollView {
                            VStack {
                                VStack  {
                                    HStack {
                                        VStack(alignment: .leading){
                                            HStack {
                                                Text(chekedPost.created_at)
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.gray)
                                                Text("Iphone")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.gray)
                                            }
                                        }

                                        Spacer()
                                       
                                        Button(action:{
                                            self.isActionSheet = true
                                            self.isActionSheetPostId = chekedPost.id
                                            
                                            
                                        }){
                                            Image(systemName:"ellipsis")
                                        }
                                        .actionSheet(isPresented: $isActionSheet) {
                                            ActionSheet(title: Text(""), message: Text("请选择您的操作"), buttons: [
                                                .default(Text("色情")) { appData.report(type:1, postId: self.isActionSheetPostId)   },
                                                .default(Text("政治敏感")) {  appData.report(type:2, postId: self.isActionSheetPostId)  },
                                                .default(Text("广告")) { appData.report(type:3, postId: self.isActionSheetPostId)   },
                                                .default(Text("违纪违法")) {  appData.report(type:4, postId: self.isActionSheetPostId)  },
                                                .default(Text("屏蔽该条数据")) {  appData.report(type:5, postId: self.isActionSheetPostId)  },
                                                .default(Text("关注")) {  appData.report(type:6, postId: self.isActionSheetPostId)  },
                                                .default(Text("屏蔽该用户的所有数据")) {  appData.report(type:8, postId: self.isActionSheetPostId) },
                                                .cancel(Text("取消"))
                                            ])
                                        }
                                        
        //                                Button(action:{
        //                                    print("点击关注123")
        //
        //                                    // 未登陆
        //                                    if appData.CurrentUserInfo.token.isEmpty {
        //                                        chekedStatus = false
        //                                        personalCenterShowSheet = true
        //                                    } else {
        //                                        chekedPost.is_focus = false
        //                                        // 1. 修改推荐页面的关注
        //                                        let pHIndex = appData.Homeposts.firstIndex(where :{$0.id == chekedPost.id})
        //                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                                            if pHIndex != nil {
        //                                                appData.Homeposts[pHIndex!].is_focus = false
        //                                            }
        //                                        }
        //
        //                                        // 2.把记录写到关注
        //                                        let fc = appData.HomefocusPublishPosts.firstIndex(where :{$0.id == chekedPost.id})
        //                                        if fc == nil {
        //                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                                                appData.HomefocusPublishPosts.append(appData.Homeposts[pHIndex!])
        //                                            }
        //                                        }
        //
        //                                        // 发送到后端
        //                                        // 点击关注按钮后
        //                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //
        //                                            let focusUser = FocusPublish(token: appData.CurrentUserInfo.token, publish_id:chekedPost.id)
        //                                            NetworkAPI.focusPost(paramters: focusUser) { result in
        //                                                switch result {
        //                                                case let .success(re):   _ = (re)
        //                                                case let .failure(error): _ = error.localizedDescription
        //                                                }
        //                                            }
        //
        //                                        }
        //                                    }
        //
        //                                }) {
        //                                    if chekedPost.is_focus == true{
        //
        //                                        Text("关注").font(.system(size: 10))
        //                                            .frame(width: 50, height: 20)
        //                                            .overlay(
        //                                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        //                                                    .stroke(Color.orange)
        //                                                    .frame(width: 50, height: 20)
        //                                            )
        //                                    }
        //                                }

                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.9)

                                    VStack(alignment: .leading) {
                                        Text(chekedPost.publish_text)
                                            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                                            .font(.system(size: 12))
                                            .lineSpacing(6)

                                    }.padding(5)

                                    HStack {
                                        Text("公司名称: \(chekedPost.company_name)")
                                            .multilineTextAlignment(.leading)
                                            .lineSpacing(20)
                                            .lineLimit(1)
                                            .foregroundColor(.orange)
                                            .font(.system(size: 10))
                                        Spacer()
                                        
                                        
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
                                }
                                 
                                Divider()

                                VStack {
                                    HStack {

                                        Text("评论 "+String(replyData.count))
                                            .font(.system(size: 14))

                                        Spacer()

                                        Text("赞 "+String(chekedPost.like_count))
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)

                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                                }
                                 
                                VStack {
         
                                    if replyData.count != 0 {
                                        
                                        ForEach(replyData, id: \.id) { // Text($0.created_at)
                                            PublishDetailReplyView(replyData: $0)
                                        }
                                        
                                    } else {
                                        Text("暂时没有内容")
                                            .foregroundColor(Color.gray)
                                            .font(.system(size: 12))
                                            .padding(19)
                                    }

                                }
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                                .padding()
                                

                                Spacer()
                                Divider().overlay(
                                    Text("End")
                                        .frame(width: 60 )
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 13))
                                        .background(Color.white)
                                    
                                )
                                
                            }
                            
                           
                            Spacer()
                        }
                        
                        
                        
                        ReplyBarView( chekedPostId: chekedPost.id,replyData : $replyData )
        //                ReplyBarView( chekedPostId: chekedPost.id, personalCenterShowSheet: $personalCenterShowSheet, chekedStatus: $chekedStatus,replyData : $replyData )
                    }
                }
                
                 
            .navigationBarBackButtonHidden(false)
            .navigationBarHidden(false)
            .navigationBarTitle(Text("详情"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { print("hello  swift") }) { Image(systemName:"ellipsis")}
            )
            
            
            
            .onAppear {
                // 页面加载数据从core到全局点选数据
//                appData.getItemById(id: Int(chekedPost.id))
                DispatchQueue.main.async {
                    appData.isHome = false
                }
                 print("isHome = 0")
                let publishReply = PublishReply( publish_id: chekedPost.id)
                NetworkAPI.publishReply(paramters: publishReply) { result in
                    switch result {
                    case let .success(re): replyData = re.data
                    case let .failure(error): _ = error.localizedDescription
                    }
                }
 
            }
            .onDisappear {
                DispatchQueue.main.async {
                    appData.isHome = true
                }
                print("isHome = 1")
            }
            
        }
    }
}

 
