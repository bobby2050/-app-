//
//  PublishRowView.swift
//  test
//
//  Created by 杨宇铎 on 12/3/20.
//

import SwiftUI

struct PublishRowView: View {
    @EnvironmentObject var appData: AppData
    
    @State var post: Post
    
    @Binding var personalCenterShowSheet: Bool
     
    @State var focusFlag:Bool = false
 
    @State var likeFlag:Bool = false
     
    @State var likeCount:Int64 = 0
    @State var isLike:Bool = false
    
    // 举报
    @Binding var isActionSheet:Bool
    @Binding var isActionSheetPostId:Int64
    @Binding var isActionSheetFocus:Bool
    
    var body: some View {

           VStack {
              
                VStack (alignment: .leading ) {
                    HStack{
                        
                        Image(systemName: "person.fill")
                            
                            .resizable()
                            .foregroundColor(Color.orange)
                            .frame(width: 25, height: 25)

                        VStack(alignment: .leading){
                            Text("\(post.nick_name)")
                                .frame(height: 40.0)
                                .font(.system(size: 14))
                                .foregroundColor(Color.orange)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                
                            HStack {
                                Text(post.created_at)
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
                            self.isActionSheetPostId = post.id
                            self.isActionSheetFocus = false
                            
                        }){
                            Image(systemName:"ellipsis").foregroundColor(Color.orange)
                        }
                        
                    }.buttonStyle(BorderlessButtonStyle()) // 对按钮来说很重要，不然 按钮无反应
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                        
                        
                    VStack  {
                        Text("\(post.publish_text)")
                            .font(.system(size: 12))
                            .lineLimit(3)
                            .lineSpacing(6)

                    }
                    HStack {
                        
                        Text(post.province_name + " " + post.city_name + " " + post.company_name)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))
                            .padding(.top, 5)
                        
                        Spacer()
                    }
                        
                }

                HStack (spacing:0) {
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Image(systemName: "message")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.gray)
                        
                        Text(String(post.reply_count))
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                            
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Spacer()

                    Button(action: {
                        print("推荐页面 - 点赞按钮")
                        // 未登陆提示
                        if appData.CurrentUserInfo.token == "" {
                            withAnimation(Animation.easeInOut(duration: 1)) {
                                personalCenterShowSheet = true
                            }
                        } else {
                            // 当前推荐页面的编号
                            let homePostIndex = appData.Homeposts.firstIndex (where :{$0.id == post.id})
                            
                            if homePostIndex != nil {
                                print("homePostIndex:\(String(describing: homePostIndex))")
                                // 初始化数据
                                
                                if likeFlag == false {
                                    likeCount = post.like_count
                                    isLike = post.is_like
//                                    withAnimation(.default) {
//                                    }
                                }
                                
                                
                                // 在关注列表的数据
                                let focusPostIndex = appData.HomefocusPublishPosts.firstIndex(where :{$0.id == post.id})
                                print("在关注的数据中的索引: \(String(describing: focusPostIndex))")
                                
                                
                                if isLike == false {
                                    print("1")
                                 
//                                    isLike = true
                                    likeCount = likeCount + 1
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        appData.Homeposts[homePostIndex!].is_like = true
                                        appData.Homeposts[homePostIndex!].like_count = likeCount
                                    }
                                    
                                    let lIndex = appData.MyLikePostId.firstIndex (where :{$0 == post.id})
                                    if lIndex == nil {
                                        appData.MyLikePostId.append(post.id)
                                    }
                                    
                                    // 更新关注列表的喜欢
                                    if focusPostIndex != nil {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            appData.HomefocusPublishPosts[focusPostIndex!].is_like = true
                                            appData.HomefocusPublishPosts[focusPostIndex!].like_count = likeCount
                                        }
                                    }
                                    
                                } else {
                                    print("2")
                                     
//                                    isLike = false
                                    likeCount = likeCount - 1
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        appData.Homeposts[homePostIndex!].is_like = false
                                        appData.Homeposts[homePostIndex!].like_count = likeCount
                                    }
                                    
                                    let lIndex = appData.MyLikePostId.firstIndex (where :{$0 == post.id})
                                    if lIndex != nil {
                                        appData.MyLikePostId.remove(at: lIndex!)
                                    }
                                    
                                     // 更新关注列表的喜欢
                                    if focusPostIndex != nil {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            appData.HomefocusPublishPosts[focusPostIndex!].is_like = false
                                            appData.HomefocusPublishPosts[focusPostIndex!].like_count = likeCount
                                        }
                                    }
                                }
                               
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                let like = Like(token: appData.CurrentUserInfo.token, post_id: post.id, state: self.isLike ? 0 : 1 )
                                NetworkAPI.LikePost(paramters: like) { result in
                                    switch result {
                                    case let .success(re):   _ = (re)
                                    case let .failure(error): _ = error.localizedDescription
                                    }
                                }
                            }

                        }

                    }) {
                        HStack{
                            
                             
                            Image(systemName: post.is_like ? "suit.heart.fill" : "suit.heart" )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(post.is_like ? Color.red : Color.gray ) //.foregroundColor(Color.orange)

                            Text( String(post.like_count) )
                                .font(.system(size: 14))
                                .foregroundColor(post.is_like ? Color.red : Color.gray )

                        }
                    }
                    .buttonStyle(BorderlessButtonStyle()) // 对按钮来说很重要，不然 按钮无反应

                    Spacer()
                }

            HStack{
                Rectangle()
                    .padding(.horizontal, -15)
                    .frame(height:10)
                    .foregroundColor(Color(red:238/255, green:238/255, blue:238/255))
                    .shadow(radius: 0.3)
            }

           }
         
           .padding()
//           .navigationBarTitle("ddddd", displayMode: .inline)
//           .statusBar(hidden: true)
             

    }
}

 
