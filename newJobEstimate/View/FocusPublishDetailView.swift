//
//  FocusPublishDetailView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 2/14/21.
//

import SwiftUI

struct FocusPublishDetailView: View {
    
    @EnvironmentObject var appData: AppData
    @Binding var focusChekedPost: Post
    @Binding var personalCenterShowSheet: Bool
    @Binding var focusChekedStatus: Bool
    @Binding var showPublishSheet: Bool
    
    @State var replyData: [ReplyData] = [ReplyData]()
    
    
    // 举报
    @State var isActionSheetFocus:Bool = false
    @State var isActionSheetPostId:Int64 = 0
     
    
    var body: some View {
        VStack {
            
            HStack {
                Text("作者: \(focusChekedPost.nick_name)")
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
                                        Text(focusChekedPost.created_at)
                                            .font(.system(size: 10))
                                            .foregroundColor(.gray)
                                        Text("Iphone")
                                            .font(.system(size: 10))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    
                                }

                                Spacer()
                               
                                Button(action:{
                                    self.isActionSheetFocus = true
                                    self.isActionSheetPostId = focusChekedPost.id
                                    
                                    
                                }){
                                    Image(systemName:"ellipsis")
                                }
                                .actionSheet(isPresented: $isActionSheetFocus) {
                                    ActionSheet(title: Text(""), message: Text("请选择您的操作"), buttons: [
                                        .default(Text("色情")) { appData.report(type:1, postId: self.isActionSheetPostId)  },
                                        .default(Text("政治敏感")) { appData.report(type:2, postId: self.isActionSheetPostId)  },
                                        .default(Text("广告")) { appData.report(type:3, postId: self.isActionSheetPostId)  },
                                        .default(Text("违纪违法")) {  appData.report(type:4, postId: self.isActionSheetPostId) },
                                        .default(Text("屏蔽该条数据")) { appData.report(type:5, postId: self.isActionSheetPostId)  },
                                        .default(Text("取消关注")) { appData.report(type:7, postId: self.isActionSheetPostId)  },
                                        .default(Text("屏蔽该用户的所有数据")) {  appData.report(type:8, postId: self.isActionSheetPostId) },
                                        .cancel(Text("取消"))
                                    ])
                                }

                            }
                            .frame(width: UIScreen.main.bounds.width * 0.9)

                            VStack(alignment: .leading) {
                                Text(focusChekedPost.publish_text)
                                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                                    .font(.system(size: 12))
                                    .lineSpacing(6)

                            }.padding(5)

                            HStack {
                                Text("公司名称: \(focusChekedPost.company_name)")
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

                                Text("评论 "+String(focusChekedPost.reply_count))
                                    .font(.system(size: 14))

                                Spacer()

                                Text("赞 "+String(focusChekedPost.like_count))
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
                .background(Color.white)
                
                
                ReplyFocusBarView( chekedPostId: focusChekedPost.id, personalCenterShowSheet: $personalCenterShowSheet, chekedStatus: $focusChekedStatus,replyData : $replyData )
            }
            .onAppear {
                // 页面加载数据从网络读取评论列表
                print("focusChekedPost.id : \(focusChekedPost.id)")
                let publishReply = PublishReply( publish_id: focusChekedPost.id)
                NetworkAPI.publishReply(paramters: publishReply) { result in
                    switch result {
                    case let .success(re): replyData = re.data
                    case let .failure(error): _ = error.localizedDescription
                    }
                }
                
            }
            
            
        }
    }
}
 
