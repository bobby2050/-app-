//
//  ContentView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 12/24/20.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var appData: AppData
    
    @State var selectIndex:Int = 1 // 导航条的控制
    @State var personalCenterShowSheet: Bool = false // 点击头像按钮
    
    @State var userState:Int = 0 // 用户【登陆、注册】
    
    // 弹出层
    @State var chekedStatus:Bool = false
    
    @State var chekedPost:Post = Post(id: 0, user_id: 0, user_name: "", nick_name: "", publish_text: "", status: 0, reply_count: 0, like_count: 0, created_at: "", updated_at: "", company_name: "", is_like: false, is_focus: false, department_name: "", group_name: "", position_name: "", province_name: "", city_name: "")
    
    @State var showPublishSheet: Bool = false // + 号按钮
    
    @State var focusChekedStatus:Bool = false
    
    @State var focusChekedPost:Post = Post(id: 0, user_id: 0, user_name: "", nick_name: "", publish_text: "", status: 0, reply_count: 0, like_count: 0, created_at: "", updated_at: "", company_name: "", is_like: false, is_focus: false, department_name: "", group_name: "", position_name: "", province_name: "", city_name: "")
    
    @State var focusShowPublishSheet: Bool = false // + 号按钮
    
    @State var error: String = "" // 错误
    @State var publishAlert:Bool = false // 发布后
    @State var isRefreshStatus:Bool = false
    @State var isRefreshStatusDown:Bool = false
    
    @State var isRefreshFocusStatusDown:Bool = false
    @State var isRefreshFocusStatusUp:Bool = false
    
    @State var isRefreshFocusRefrsh:Bool = false
    @State var isFocusRefresh:Bool = false
    @State var isNew:Bool = false
    
    
    let timer = Timer.publish(every: 30, on: .main, in: .default).autoconnect()
    let timer5 = Timer.publish(every: 5, on: .main, in: .default).autoconnect()
    
    // 举报
    @State private var isActionSheet = false // 推荐
    @State private var isActionSheetFocus =  false // 关注
    @State private var isActionSheetPostId:Int64 = 0
    
     
    
    
    var body: some View {
 
        VStack(alignment: .center, spacing: 0 ){
           
            if appData.isHome == true {
                HStack{
                    HomeNavigationBarView(selectIndex: $selectIndex, personalCenterShowSheet: $personalCenterShowSheet)
                }
            }
           

//        GeometryReader { gmr in
          
            NavigationView {

//                    GeometryReader { geometry in

                    LazyVStack(spacing:15) {
                         
                            TabView (selection: $selectIndex) {

                                // 关注列表
                                VStack( alignment: .center) {
                                    ZStack (alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                                        
                                        FocusPublishListView( focusChekedPost: $focusChekedPost,
                                                                focusChekedStatus: $focusChekedStatus,
                                                                personalCenterShowSheet: $personalCenterShowSheet,
                                                                isActionSheetFocus: $isActionSheetFocus,
                                                                isActionSheetPostId: $isActionSheetPostId
                                                                )
                                        .actionSheet(isPresented: $isActionSheetFocus) {
                                            ActionSheet(title: Text(""), message: Text("请选择您的操作"), buttons: [
                                                .default(Text("色情")) { appData.report(type:1, postId: self.isActionSheetPostId)  },
                                                .default(Text("政治敏感")) {  appData.report(type:2, postId: self.isActionSheetPostId) },
                                                .default(Text("广告")) { appData.report(type:3, postId: self.isActionSheetPostId)  },
                                                .default(Text("违纪违法")) {  appData.report(type:4, postId: self.isActionSheetPostId) },
                                                .default(Text("屏蔽该条数据")) { appData.report(type:5, postId: self.isActionSheetPostId)  },
                                                .default(Text("屏蔽该用户的所有数据")) {  appData.report(type:8, postId: self.isActionSheetPostId) },
                                                .default(Text("取消关注")) {  appData.report(type:7, postId: self.isActionSheetPostId) },
                                                
                                                .cancel(Text("取消"))
                                            ])
                                        }
                                            
                                        VStack{
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            HStack {
                                                Button(action:{
                                                    print("点击 + 号")
                                                    if appData.CurrentUserInfo.nickName == "" {
                                                        personalCenterShowSheet = true // 头像按钮显示
                                                    } else {
                                                        showPublishSheet = true // + 号按钮显示
                                                    }
                                                    
                                                }) {
                                                    Image(systemName: "plus")
                                                        .resizable()
                                                        .foregroundColor(Color.orange)
                                                        .frame(width: 35, height: 35)
                                                        .padding()
        //                                                .padding(.init(top: 5, leading: 5, bottom: 55, trailing: 25))
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                    
                                    }
                                    .sheet(isPresented: $focusChekedStatus) {  // 关注点击详情
                                        
                                        FocusPublishDetailView( focusChekedPost: $focusChekedPost,
                                                                personalCenterShowSheet: $personalCenterShowSheet,
                                                                focusChekedStatus: $focusChekedStatus,
                                                                showPublishSheet: $focusShowPublishSheet
                                                                )
                                        
                                    }
                                    
                                }.tag(0)
                                

                                // 推荐列表
                                VStack( alignment: .center,spacing:15) {
                                    ZStack (alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                                        
                                        PublishListView( chekedPost: $chekedPost,
                                                            chekedStatus: $chekedStatus,
                                                            personalCenterShowSheet: $personalCenterShowSheet,
                                                            isActionSheet:$isActionSheet,
                                                            isActionSheetPostId: $isActionSheetPostId,
                                                            isActionSheetFocus:$isActionSheetFocus)
                                            .padding([.top, .bottom])
                                            .actionSheet(isPresented: $isActionSheet) {
                                                ActionSheet(title: Text(""), message: Text("请选择您的操作"), buttons: [
                                                    .default(Text("色情")) { appData.report(type:1, postId: self.isActionSheetPostId)   },
                                                    .default(Text("政治敏感")) {  appData.report(type:2, postId: self.isActionSheetPostId)  },
                                                    .default(Text("广告")) { appData.report(type:3, postId: self.isActionSheetPostId)   },
                                                    .default(Text("违纪违法")) {  appData.report(type:4, postId: self.isActionSheetPostId)  },
                                                    .default(Text("屏蔽该条数据")) {  appData.report(type:5, postId: self.isActionSheetPostId)  },
                                                    .default(Text("屏蔽该用户的所有数据")) {  appData.report(type:8, postId: self.isActionSheetPostId) },
                                                    .default(Text("关注")) {  appData.report(type:6, postId: self.isActionSheetPostId)  },
                                                    .cancel(Text("取消"))
                                                ])
                                            }
                                        
                                        VStack{
                                            
                                            // 下拉
                                            if isNew == true {
                                                HStack {
                                                    if isRefreshStatusDown == false {
                                                        Button(action:{
                                                            isRefreshStatusDown = true
                                                            updatePostNew()
                                                        }){
                                                            Circle()
                                                                .fill(Color.orange)
                                                                .overlay(Text("NEW!").foregroundColor(.white))
                                                                .frame(width:45,height:45)
                                                                .padding()
                                                        }
                                                    } else {
                                                        ProgressView()
                                                            .frame(width:45,height:45)
                                                            .padding()
                                                    }
                                                }
                                            }
                                            
                                            // 刷新
                                            HStack {
                                            }
                                            
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            HStack {
                                                Button(action:{
                                                    print("点击 + 号")
                                                    if appData.CurrentUserInfo.nickName == "" {
                                                        personalCenterShowSheet = true // 头像按钮显示
                                                    } else {
                                                        showPublishSheet = true // + 号按钮显示
                                                    }
                                                    
                                                }) {
                                                    Image(systemName: "plus")
                                                        .resizable()
                                                        .foregroundColor(Color.orange)
                                                        .frame(width: 35, height: 35)
                                                        .padding()
                                                }
                                            }
                                             
                                            
                                            // 上拉
                                            HStack  {
                                                
                                                if isRefreshStatus == false {
                                                    Button(action: {
                                                        isRefreshStatus = true
                                                        updateData2up()
                                                        print("加载老数据")
                                                        
                                                    }, label: {
                                                            
                                                        Circle()
                                                            .fill(Color.orange)
                                                            .overlay(Text("LAST").foregroundColor(.white))
                                                            .frame(width:45,height:45)
                                                            .padding()
                                                        
                                                    })
                                                } else {
                                                    ProgressView()
                                                        .frame(width:45,height:45)
                                                        .padding()
                                                }
                                                
                                            }
                                        }
                                    }
//                                    .sheet(isPresented: $chekedStatus) {  // 推荐点击详情
//                                        PublishDetailView(chekedPost: $chekedPost,
//                                                            personalCenterShowSheet: $personalCenterShowSheet,
//                                                            chekedStatus: $chekedStatus,
//                                                            showPublishSheet: $showPublishSheet
//                                                            )
//                                    }
                                }.tag(1)

                                    
                            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                         
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                        .onAppear{
                            
                            // 1.更新天气图片
                            appData.currentTimeImg()
                            
                            // 2.请求服务器最新通知
                            appData.revServerNotification()
                            
                            // 3.启动后，从coredata读取写入post
                            if appData.Homeposts.isEmpty {
                                appData.getUpdatePost()
                            
                            } else {
                                appData.getUpdatePostLikeReplyCount()
                            }
                            print("打印Homeposts：")
                            print(appData.Homeposts)
                        }
                        .onReceive(timer) { _ in
                            // 每个1分钟从服务器拉取一次数据写入coredata
        //                     print("每隔1分钟到时间了，执行从服务器更新最新的数据写入coredata")
        //                    appData.getUpdatePost()
        //                    appData.getCoreDataToModel()
        //                    appData.coreDataSyncToHomePosts( )
                            
                            // 1.拉取到有新数据执行
                            appData.getUpdateNew()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                print("TmpNewDataCount: \(appData.TmpNewDataCount)")
                                if appData.TmpNewDataCount != 0 {
                                    withAnimation(Animation.easeInOut(duration: 1)) {
                                        isNew = true
                                    }
                                }
                            }
                            
                            // 2.
                            appData.currentTimeImg()
                            
                            // 3.请求服务器最新通知
                            appData.revServerNotification()

                        }
                        .onReceive(timer5) { _ in
                                // 每隔多少秒执行一次
        //                    appData.coreDataSyncToHomePosts( )
            
                        }
                        
                        .sheet(isPresented: $showPublishSheet) { // 发布按钮
                            PublishView(popOver: $showPublishSheet)
                        }
                        
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                     
                     
                        
                    
                 
                 
            }
            
           
            .navigationViewStyle(StackNavigationViewStyle()) // 重点
            .padding(0)
//            .frame( height: gmr.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        }
       
        .border(Color.green)
        .background(Color.red)
        
         
       

            
    
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    } .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(false)
//        .navigationBarHidden(false)
//    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    .edgesIgnoringSafeArea(.all)
 
         
         

        // 点击头像
//        if personalCenterShowSheet == true {
//            if appData.CurrentUserInfo.token != "" {
//
//                PersonalCenterView(personalCenterShowSheet: $personalCenterShowSheet)
////                    .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
//                    .background(Color.white)
//                    .ignoresSafeArea(.all)
//                    .edgesIgnoringSafeArea(.all)
//            } else {
//
//                UserStateView( personalCenterShowSheet: $personalCenterShowSheet, userState: $userState)
////                    .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
//                    .background(Color.white)
//                    .ignoresSafeArea(.all)
//                    .edgesIgnoringSafeArea(.all)
//            }
//        }
        
    }
    
    
    // 刷新 关注
    func updateDataRefrsh() {
        print("update data..... 刷新 关注")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
            appData.getFocusPublish()
            isRefreshFocusRefrsh = false
        }
    }
    
    // 下拉 关注
    func updateData() {
        print("update data..... 下拉 关注")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
//            appData.getFocusNewData()
            isRefreshFocusStatusDown = false
        }
    }
    
    // 上拉 关注
    func updateDataup() {
        print("update data..... 上拉 关注")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
//            appData.getFocusOldData()
            isRefreshFocusStatusUp = false
        }
    }
    
    //--------------------------------------------- 推荐 ---------------------------------------
    
    // 刷新
//    func updateData2Refresh() {
//        print("update data..... 下拉 推荐")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
//            appData.getNewData()
//            isFocusRefresh = false
//        }
//
//    }
    
    
    // 下拉 推荐
    func updatePostNew() {
        print("update data..... 下拉 推荐")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
            appData.displyNewPostData()
            withAnimation(.default) {
                isRefreshStatusDown = false
                isNew = false
            }
            
        }
    }
    
    // 上拉 推荐
    func updateData2up() {
        print("推荐 -  获取老数据")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1)   {
            appData.getOldHomePosts()
            isRefreshStatus = false
        }

    }
    
//    func getItems() {
//        do {
//
//            self.items = try context.fetch(MyPublish.fetchRequest())
//            DispatchQueue.main.async {
//                // 重新加载页面
//            }
//
//        }
//        catch{
//
//        }
//
//    }

}

 
 
