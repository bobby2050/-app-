//
//  ReplyFocusBarView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 2/18/21.
//

import SwiftUI

struct ReplyFocusBarView: View {
    @EnvironmentObject var appData: AppData
    var chekedPostId: Int64
    @State private var replyText = ""
    @State private var isDisplay = false
    @State private var isAlertEnable = false
    @Binding var personalCenterShowSheet: Bool
    @Binding var chekedStatus: Bool
    @State private var text:String = ""
    @Binding var replyData: [ReplyData]
    var body: some View {
         
            HStack{
                Spacer()
                
                Button(action:{
                    if appData.CurrentUserInfo.token.isEmpty {
                        print("空")
                        chekedStatus = false
                        personalCenterShowSheet = true
                    } else {
                        isDisplay = true
                    }

                }) {
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("回复 " )
                }
                .sheet(isPresented: $isDisplay, onDismiss: {
                    print("Detail View Dismissed")
                }, content: {

                    VStack (alignment:.center) {
                        
                         
                        Text("您的回复").font(.title).padding()
                        Text("请您用简练的语言结构，不必匆匆提交")
                            .font(.footnote)
                            .frame(width: UIScreen.main.bounds.width, alignment: Alignment.center)
                            .foregroundColor(.gray)
                             
                        
                        VStack(alignment: HorizontalAlignment.leading) {
                            
                            TextEditor(text: $replyText)
                                .frame(width: 240, height: 80)
                                .border(Color.gray, width: 1)
                                .padding(5)
                                .onTapGesture {
                                    print("点击了键盘")
                                }
                            
                            Button(action:{
                                
                                print("提交回复")
                                print("内容 " + replyText)
                                replyData.append(ReplyData(id: 0, publish_id: chekedPostId, user_id: appData.CurrentUserInfo.user_id, nick_name: appData.CurrentUserInfo.nickName, reply_text: replyText, status: 0, created_at: ""))
                                 
                                let reply = Reply(publish_id: chekedPostId, token: appData.CurrentUserInfo.token, reply_text: replyText)
                                NetworkAPI.reply(paramters: reply) { result in
                                    switch result {
                                    case let .success(re):  _ = re.data;text = "审核成功后才会展示出来"; isAlertEnable = true
                                    case let .failure(error): _ = error.localizedDescription
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
                                    let publishReply = PublishReply(publish_id: Int64(chekedPostId))
                                    NetworkAPI.publishReply(paramters: publishReply) { result in
                                        switch result {
                                        case let .success(re): self.replyData = re.data
                                        case let .failure(error): _ = error.localizedDescription
                                        }
                                    }
                                    
                                }
                                
                                
                                //  在关注中更新 推荐的回复数
                               
                                let homeReplyIndex =     appData.Homeposts.firstIndex (where :{$0.id == chekedPostId})
                                 
                                if homeReplyIndex != nil {
                                    appData.Homeposts[homeReplyIndex!].reply_count += 1
                                }
                                
                                
                                
                                
                                
                                //
//                                chekedPostId
//                                appData.Homeposts
                                appData.updatePostFocusReplyNum(postId: Int64(chekedPostId))
                                
                                if replyText.isEmpty {
                                    text = "您提交的内容不能为空"
                                    isAlertEnable = true
                                    
                                } else {
                                    self.isDisplay = false
                                    // 清空内容
                                    replyText = ""
                                }
                                
                            }) {
                                Text("提交")
                                    .frame(width: 50, height: 30, alignment: .center)
                                    .foregroundColor(Color.blue)
                                    .background(Color.blue.opacity(0.1))
                                    .shadow(radius: 10 )
                                    .padding()
                                     
                            }
                           
                             .alert(isPresented: $isAlertEnable) {
                                Alert(title: Text("提示"), message: Text(text.description), dismissButton: .default(Text("OK")))
                            }
                              
                            
                        }
                        Text("注意:言辞表达是您最真实的想法。新app上线不易，谢谢您的支持")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                        
                    }
 
                })

                Spacer()
                Divider()
 
            }
            .frame(height: 40)
            .background(Color.gray)

    }
}

 
