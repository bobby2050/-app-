//
//  PublishListFocusView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 12/31/20.
//

import SwiftUI

struct PublishFocusRowView: View {
    @EnvironmentObject var appData: AppData
    
    @State var post:Post

    @Binding var personalCenterShowSheet: Bool
     
    // 关注列表默认都是true
    @State var focusFlag:Bool = true
    
    // 喜欢
    @State var likeFlag:Bool = false
    @State var isLike:Bool = false //post.is_like
    @State var likeCount:Int64 = 0 // post.like_count
 
    @State var currentFocusPostIndex:Int = 0
    
    // 举报
    @Binding var isActionSheetFocus:Bool
    @Binding var isActionSheetPostId:Int64
    
    
    var body: some View {
        
           VStack {
                VStack (alignment: .leading ) {
                    HStack{
                        Image(systemName: "person.fill").resizable().frame(width: 25, height: 25)
                            .foregroundColor(Color.orange)
                        
                        VStack(alignment: .leading){
                            Text("\(post.nick_name)")
                                .frame(height: 40.0)
                                .foregroundColor(Color.orange)
                                .font(.system(size: 14))
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
                            self.isActionSheetFocus = true
                            self.isActionSheetPostId = post.id
                            
                        }){
                            Image(systemName:"ellipsis").foregroundColor(Color.orange)
                        }.buttonStyle(BorderlessButtonStyle())

                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                        
                    VStack  {
                        Text(" \(post.publish_text)")
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
                        print("关注页面 - 点赞按钮")
                        // 推荐列表
//                        print(appData.Homeposts)
                        if  likeFlag == false {
                            isLike = post.is_like
                            likeCount = post.like_count
                        }

                        if isLike == false  {
                            print("打印： 1")
                            
                            // 1.当前关注页面
//                            isLike = true
                            likeCount = likeCount + 1

                            let fIndex = appData.HomefocusPublishPosts.firstIndex (where :{Int($0.id) == Int(post.id)})
                            if fIndex != nil {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    appData.HomefocusPublishPosts[fIndex!].is_like = true
                                    appData.HomefocusPublishPosts[fIndex!].like_count  = likeCount
                                }
                            }
                            
                            // 2. 把postID写入MyLikePostId
                            let lIndex = appData.MyLikePostId.firstIndex (where :{$0 == post.id})
                            if lIndex == nil {
                                appData.MyLikePostId.append(post.id)
                            }
                            
                            // 3.更新推荐列表
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                let homeLikeIndex = appData.Homeposts.firstIndex (where :{Int($0.id) == Int(post.id)})
                                if homeLikeIndex != nil {
                                    appData.Homeposts[homeLikeIndex!].is_like = true
                                    appData.Homeposts[homeLikeIndex!].like_count  = likeCount
                                }
                            }

                        } else {
                            print("打印： 2")
                            
                            // 1.当前关注页面
//                            isLike = false
                            likeCount = likeCount - 1
                            
                            let fIndex = appData.HomefocusPublishPosts.firstIndex (where :{Int($0.id) == Int(post.id)})
                            if fIndex != nil {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    appData.HomefocusPublishPosts[fIndex!].is_like = false
                                    appData.HomefocusPublishPosts[fIndex!].like_count  = likeCount
                                }
                            }
                            
                            // 2.把postID从MyLikePostId移除
                            let tmpLikeIndex = appData.MyLikePostId.firstIndex(where:{$0 == post.id})
                            if tmpLikeIndex != nil {
                                appData.MyLikePostId.remove(at: tmpLikeIndex!)
                            }

                            // 3.更新推荐列表
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                let homeLikeIndex = appData.Homeposts.firstIndex (where :{Int($0.id) == Int(post.id)})
                                if homeLikeIndex != nil {
                                    appData.Homeposts[homeLikeIndex!].is_like = false
                                    appData.Homeposts[homeLikeIndex!].like_count = likeCount
                                }
                            }
                        }

                        // 点击喜欢按钮后
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            let like = Like(token: appData.CurrentUserInfo.token, post_id: post.id, state: self.isLike ? 0 : 1 )
                            NetworkAPI.LikePost(paramters: like) { result in
                                switch result {
                                case let .success(re):   _ = (re)
                                case let .failure(error): _ = error.localizedDescription
                                }
                            }
                        }

                    }) {
                        HStack{
 
                            Image(systemName: (post.is_like ? "suit.heart.fill" : "suit.heart") )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(post.is_like ? Color.red : Color.gray )

                            Text(  String(post.like_count) )
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
 

    }
}
 
