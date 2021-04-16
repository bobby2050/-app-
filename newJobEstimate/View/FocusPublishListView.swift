//
//  FocusPublishListView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 2/14/21.
//

import SwiftUI

struct FocusPublishListView: View {
    @EnvironmentObject var appData: AppData
    
    @Binding var focusChekedPost: Post
    @Binding var focusChekedStatus: Bool
    @Binding var personalCenterShowSheet: Bool
    
    // 举报
    @Binding var isActionSheetFocus:Bool
    @Binding var isActionSheetPostId:Int64
    
    var body: some View {
        VStack{
            if appData.HomefocusPublishPosts.isEmpty {
                VStack {
                    Spacer()
                    if appData.ServerNotification != "" {
                        withAnimation {
                            HStack{
                                Image(systemName:"megaphone")
                                    .foregroundColor(Color.red)
                                   
                                Text("\(appData.ServerNotification)")
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 14))

                            }.padding()
                        }
                        
                    }
                    Image(systemName: "binoculars.fill")
                        .frame(width: UIScreen.main.bounds.width)
                        .foregroundColor(Color.orange)
                    
                    Text("暂时没有记录")
                        .font(.body)
                        .foregroundColor(Color.orange)
                          
                     
                    if !appData.CurrentUserInfo.token.isEmpty{
                        
                        Text("Hi, \(appData.CurrentUserInfo.nickName) 到推荐列表中瞅瞅你感兴趣的条目吧" )
                            .font(.system(size: 13))
                            .foregroundColor(Color.orange)
                            .padding()
                    }
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack(spacing:0){
                        if appData.ServerNotification != "" {
                            withAnimation {
                                HStack{
                                    Image(systemName:"megaphone")
                                        .foregroundColor(Color.red)
                                       
                                    Text("\(appData.ServerNotification)")
                                        .foregroundColor(Color.red)
                                        .font(.system(size: 14))

                                }.padding()
                            }
                            
                        }
                        
                        ForEach(appData.HomefocusPublishPosts, id:\.self) { post in // , id: \.self

                            PublishFocusRowView(post: post,
                                                personalCenterShowSheet: $personalCenterShowSheet,
                                                isActionSheetFocus:$isActionSheetFocus,
                                                isActionSheetPostId: $isActionSheetPostId)
                                .onTapGesture {
                                    print("关注列表页 - 点击的id：\(post.id)")
                                    focusChekedPost =  post
                                    focusChekedStatus = true
                                }
                        }
                    }
                }
                
                
            }
        }
    }
}

 
