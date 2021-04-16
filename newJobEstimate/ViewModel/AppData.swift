//
//  MyData.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 12/24/20.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import CoreData


class AppData: ObservableObject {
    @Published var HomefocusPublishPosts: [Post] = [Post]() // 关注列表
    @Published var Homeposts: [Post] = [Post]() // 推荐列表
    @Published var CurrentUserInfo: LoginUserInfo = LoginUserInfo(nickName: "", token: "", user_id: 0) // 存储用户信息
    @Published var MyFocus: [MyFocusEntity] = [MyFocusEntity]() // 我的关注
    
    @Published var myPulishEntity:[MyPulishEntity] = [MyPulishEntity]() // 我的发布
    
    
    @Published var ServerNotification:String = "" // 服务器通知
 
    @Published var CurrentTimeImg:String = "cloud.bolt.rain.fill"
    
    // 全局喜欢文章id
    @Published var MyLikePostId:[Int64] = [Int64] ()
    
    // 全局关注文章id
    var MyFocusPostId:[Int64] = [Int64] ()
    
    
    // 推荐
    private var postDic:[Int:Int] = [:] //id: index
    
    // 关注推荐
    private var focusPostDic:[Int:Int] = [:] //id: index
    
    private var lastId:Int = 0  // 2 推荐 因为是倒序，所以两个值是反的
    private var firstId:Int = 0 // 35 推荐
    
    private var focusLastId:Int = 0  // 2 关注 因为是倒序，所以两个值是反的
    private var focusFirstId:Int = 0 // 35 关注
    
    
    var HomepostMinId:Int64 = 0 // 推荐最小的id
    var HomepostMaxId:Int64 = 0 // 推荐最大的id
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var TmpNewData: [RevPost] = [RevPost]() // 临时把最新的post写到这里
    
    var TmpNewDataCount:Int = 0
    
    // 首页
    @Published var isHome:Bool = true
    
//    func publishDataInit(restatusInit:Bool) {
        
//        self.myPublishFocusInitData(restatusInit: restatusInit)
        
//        self.myPublishInitData(restatusInit: restatusInit)
//
//        self.myFocusInitData(restatusInit: restatusInit)
        
        
//    }
    
    //  关注列表
//    func myPublishFocusInitData(restatusInit:Bool)  {
//        if restatusInit == true{
//            self.AppDataHomefocusPosts = [Post]()
//        }
//
//        let focuspostsParameter = PostsParameter(flag: "normal", token: CurrentUserInfo.token, publishId: 0 )
//        NetworkAPI.FocusPosts(paramters: focuspostsParameter) {  result in
//            switch result {
//            case let .success(re): self.AppDataHomefocusPosts = re.data; self.focusSortPost()
//            case let .failure(error): _ = error.localizedDescription
//            }
//        }
//        print("关注更新完毕")
//    }
    
    // 推荐列表
//    func myPublishInitData(restatusInit:Bool)  {
//        if restatusInit == true{
//            self.Homeposts = [Post]()
//        }
//        let postsParameter = PostsParameter(flag: "normal", token: CurrentUserInfo.token, publishId: 0)
//        NetworkAPI.Posts(paramters: postsParameter) { result in
//            switch result {
//            case let .success(re): self.Homeposts = re.data; self.sortPost()
//            case let .failure(error): _ = error.localizedDescription
//            }
//        }
//
//    }
    
    func revServerNotification() {
        
        NetworkAPI.RevServerNotication() { result in
            switch result {
            case let .success(re): self.ServerNotification = re.data;
            case let .failure(error): _ = error.localizedDescription
            }
        }
    }
    
    // 我的关注
    func myFocusInitData(restatusInit:Bool) {
        print("我的关注")
        if restatusInit == true{
            self.MyFocus = [MyFocusEntity]()
        }
        
        let myFocusParameter = MyFocusParameter( token: CurrentUserInfo.token )
        NetworkAPI.MyfocusList(paramters: myFocusParameter) { result in
            switch result {
            case let .success(re): self.MyFocus = re.data;
            case let .failure(error): _ = error.localizedDescription
            }
        }
    }
    
    // 推荐
//    func sortPost() {
//        // 物理结构，帖子id 对应列表的位置序号
//        for i in 0 ..< Homeposts.count {
//            let post = Homeposts[i]
//            postDic[Int(post.id)] = i
//        }
//        print("整理后的结果：")
//        print(postDic)
//
//        print("count: \(Homeposts.count)")
//        if Homeposts.count != 0 {
//            lastId = Int(Homeposts[Homeposts.count - 1].id)
//            firstId = Int(Homeposts[0].id)
//
//        }
//
//        print("lastId = \(lastId), firstId = \(firstId)") // lastId = 2, firstId = 35
//    }
    
    // 关注 排序
//    func focusSortPost() {
//        print("关注 排序")
//        // 物理结构，帖子id 对应列表的位置序号
//        for i in 0 ..< HomefocusPublishPosts.count {
//            let post = HomefocusPublishPosts[i]
//            focusPostDic[Int(post.id)] = i
//        }
//        print("整理后的结果：")
//        print(focusPostDic)
//
//        focusLastId = Int(HomefocusPublishPosts[HomefocusPublishPosts.count - 1].id)
//        focusFirstId = Int(HomefocusPublishPosts[0].id)
//        print("focusLastId = \(focusLastId), focusFirstId = \(focusFirstId)") // lastId = 2, firstId = 35
//    }
    
    // [id: index]
    // [52: 0, 50: 2, 51: 1, 49: 3, 48: 4]
//    func getFocusPostId(forId id:Int) -> Int {
//        return focusPostDic[id] ?? 0
//    }
    // 关注和推荐都可以使用，推荐包含关注
//    func getPost(forId id:Int) -> Post? {
//        if let index = postDic[id] {
//            return Homeposts[index]
//        }
//        return nil
//    }
    // --------------------------------- 推荐 ---------------------------------
    
    // 更新
//    func updateData2Refresh() {
//        self.publishDataInit(restatusInit: true)
//    }
    // 下拉 更新最新数据 推荐
//    func getNewData() {
//        let postsParameter = PostsParameter(flag: "first", token: self.CurrentUserInfo.token, publishId: firstId )
//        NetworkAPI.Posts(paramters: postsParameter) { result in
//            switch result {
//            case let .success(re): self.AppDataHomeposts.insert(contentsOf: re.data, at: 0) ; self.sortPost()
//            case let .failure(error): _ = error.localizedDescription
//            }
//        }
//        self.publishDataInit(restatusInit: false)
//        self.sortPost()
//    }
    
    // 上拉 获取老数据 推荐
//    func getOldData() {
//        let postsParameter = PostsParameter(flag: "last", token: self.CurrentUserInfo.token, publishId: lastId )
//        NetworkAPI.Posts(paramters: postsParameter) { result in
//            switch result {
//            case let .success(re): self.Homeposts.append(contentsOf: re.data) ; self.sortPost()
//            case let .failure(error): _ = error.localizedDescription
//            }
//        }
//    }
    
    
    
    // --------------------------------- 关注 ---------------------------------
    
    // 关注 刷新
//    func getFocusRefrshData() {
//        self.myPublishFocusInitData(restatusInit: true)
//    }
    
    // 下拉 更新最新数据 关注
//    func getFocusNewData() {
 
//        let postsParameter = PostsParameter(flag: "first", token: self.CurrentUserInfo.token, publishId: focusFirstId )
//        NetworkAPI.FocusPosts(paramters: postsParameter) { result in
//            switch result {
//            case let .success(re): self.AppDataHomefocusPosts.insert(contentsOf: re.data, at: 0) ; self.focusSortPost()
//            case let .failure(error): _ = error.localizedDescription
//            }
//        }
//        self.myPublishFocusInitData(restatusInit: false)
//        self.focusSortPost()
//    }
    
    // 下拉 更新最新数据 关注
//    func getFocusOldData() {
//        let postsParameter = PostsParameter(flag: "last", token: self.CurrentUserInfo.token, publishId: focusLastId )
//        NetworkAPI.FocusPosts(paramters: postsParameter) { result in
//            switch result {
//            case let .success(re): self.AppDataHomefocusPosts.append(contentsOf: re.data) ; self.focusSortPost()
//            case let .failure(error): _ = error.localizedDescription
//            }
//        }
//    }
    
    // 更新推荐列表的 关注状态
    func updateAppDataHomePostsBtn(user_id:Int) {
        for index in 0 ..< Homeposts.count {
            if Homeposts[index].user_id == user_id {
                Homeposts[index].is_focus = false
            }
        }
    }
    
    // 更新关注列表的 关注状态
//    func updateAppDataHomefocusPosts(user_id:Int) {
//        print("删除关注列表的数据")
//        for (index,v) in   AppDataHomefocusPosts.enumerated() {
//            print(v)
//            if v.user_id != user_id {
//                AppDataHomefocusPosts.remove(at: index)
//            }
//        }
//    }
    
    //
//    func homefocusPostsEmpty () {
//        AppDataHomefocusPosts = [Post]()
//    }
    
    // MARK: - Core数据
    
    // 从服务端拉取最新的Post
    func getUpdateNew() {
         
        print("定时时间从服务端拉取最新的Post")
        let postsParameter = PostsParameter(flag: "first", token: CurrentUserInfo.token, publishId: HomepostMaxId)
        NetworkAPI.Posts(paramters: postsParameter) { result in
            switch result {
            case let .success(re): self.displyNewData(myData: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
    }
    
    func displyNewData(myData: [RevPost]) {
        TmpNewData =  myData
        
        TmpNewDataCount = myData.count
    }
    
    
    
    
    
    func displyNewPostData() {
        print("初始化-1 数量：\(TmpNewData.count)")

        // 获取post id
        var postIds:[Int64] = [Int64]()

        for i in 0 ..< TmpNewData.count {
            self.createItem(post: TmpNewData[i])
            postIds.append(TmpNewData[i].id)
        }

        print("结束")

        // 请求网络，获取 回复数和喜欢数
        let postId = PostIds(  token: CurrentUserInfo.token, post_ids: postIds)
        NetworkAPI.updatePostReplyLike(paramters: postId) { result in
            switch result {
            case let .success(re): self.coreDataSyncToHomeNewPosts(data: self.TmpNewData, replylike: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
        
    }

    // Core Data 同步到 HomePosts
    func coreDataSyncToHomeNewPosts(data: [RevPost], replylike:[ReplyLikeData]) {
        print("初始化 - 3 同步到HomePosts")
        var post:[Post] = [Post]()

        for i in 0 ..< data.count {
            print(data[i])
            var islike = false
            if MyLikePostId.contains(data[i].id){
                islike = true
            }

            var reply_num:Int64 = 0
            var like_num:Int64 = 0
            var is_focus:Bool = false
            (reply_num, like_num, is_focus) = getPostReplyLikeCount(id: data[i].id, replylike: replylike)
//            print("初始化 - Id: \(data[i].id), reply_num: \(reply_num), like_num: \(like_num), is_focus: \(is_focus)")

            let item:Post = Post(
                id: data[i].id,
                user_id: data[i].user_id,
                user_name: data[i].user_name,
                nick_name: data[i].nick_name,
                publish_text: data[i].publish_text,
                status: data[i].status,
                reply_count: reply_num,
                like_count: like_num,
                created_at: data[i].created_at,
                updated_at: data[i].updated_at,
                company_name: data[i].company_name,
                is_like: islike,
                is_focus: is_focus,
                department_name: data[i].department_name,
                group_name: data[i].group_name,
                position_name: data[i].position_name,
                province_name: data[i].province_name,
                city_name: data[i].city_name
            )

            post.append(item)
        }

        models = [MyPublish]() // 使用完清除数据
        Homeposts.insert(contentsOf: post, at: 0)

        // 得到最大、最小编号
        (HomepostMinId,HomepostMaxId) = getHomePostMaxMinId ()
        print("HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")


        // 最后清空数据
        TmpNewData = [RevPost]()
        TmpNewDataCount = 0
    }
    
    
    //----------------------------------------------------------------------
    
    func getUpdatePostLikeReplyCount() {
        // 获取post id
        var postIds:[Int64] = [Int64]()
        
        for i in 0 ..< Homeposts.count {
            postIds.append(Homeposts[i].id)
        }
        
        // 请求网络，获取 回复数和喜欢数
        let postId = PostIds(  token: CurrentUserInfo.token, post_ids: postIds)
        NetworkAPI.updatePostReplyLike(paramters: postId) { result in
            switch result {
            case let .success(re): self.coreDataSyncToHomePostsLikeReplyCount(replylike: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }

    }
    
    func coreDataSyncToHomePostsLikeReplyCount(replylike:[ReplyLikeData])  {
        for i in 0 ..< Homeposts.count {
            for j in 0 ..<  replylike.count {
                
                var reply_num:Int64 = 0
                var like_num:Int64 = 0
                var is_focus:Bool = false
                
                var islike = false
                if MyLikePostId.contains(Homeposts[i].id){
                    islike = true
                }
                

                (reply_num, like_num, is_focus) = getPostReplyLikeCount(id: Homeposts[i].id, replylike: replylike)
                
                if Homeposts[i].id == replylike[j].id {
                    Homeposts[i].reply_count = reply_num
                    Homeposts[i].like_count = like_num
                    Homeposts[i].is_focus = is_focus
                    Homeposts[i].is_like = islike
                    continue
                }
                
                
                
            }
            
        }
    }
    
    
    // 从服务器拉去最新的数据
    func getUpdatePost() {
        print("初始化-0")
        let postsParameter = PostsParameter(flag: "normal", token: CurrentUserInfo.token, publishId: 0)
        NetworkAPI.Posts(paramters: postsParameter) { result in
            switch result {
            case let .success(re): self.displyData(myData: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
        
    }
    
    func displyData(myData: [RevPost]) {
        print("初始化-1 数量：\(myData.count)")

        // 获取post id
        var postIds:[Int64] = [Int64]()
        
        for i in 0 ..< myData.count {
            self.createItem(post: myData[i])
            postIds.append(myData[i].id)
        }

        print("结束")
        
        
        // 请求网络，获取 回复数和喜欢数
        let postId = PostIds(  token: CurrentUserInfo.token, post_ids: postIds)
        NetworkAPI.updatePostReplyLike(paramters: postId) { result in
            switch result {
            case let .success(re): self.coreDataSyncToHomePosts(data: myData, replylike: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }

    }

    // 临时使用
    private var models = [MyPublish]()
    private var modelOne = [MyPublish]()
    
    
    
    // Core Data 同步到 HomePosts
    func coreDataSyncToHomePosts(data: [RevPost], replylike:[ReplyLikeData]) {
        print("初始化 - 3 同步到HomePosts")
        print("[replylike]:")
        print( replylike)
        print("-----------------")
        var post:[Post] = [Post]()
        
        for i in 0 ..< data.count {
//            print(data[i])
            var islike = false
            if MyLikePostId.contains(data[i].id){
                islike = true
            }
            
            var reply_num:Int64 = 0
            var like_num:Int64 = 0
            var is_focus:Bool = false
            (reply_num, like_num, is_focus) = getPostReplyLikeCount(id: data[i].id, replylike: replylike)
//            print("初始化 - Id: \(data[i].id), reply_num: \(reply_num), like_num: \(like_num), is_focus: \(is_focus)")
            
            let item:Post = Post(
                id: data[i].id,
                user_id: data[i].user_id,
                user_name: data[i].user_name,
                nick_name: data[i].nick_name,
                publish_text: data[i].publish_text,
                status: data[i].status,
                reply_count: reply_num,
                like_count: like_num,
                created_at: data[i].created_at,
                updated_at: data[i].updated_at,
                company_name: data[i].company_name,
                is_like: islike,
                is_focus: is_focus,
                department_name: data[i].department_name,
                group_name: data[i].group_name,
                position_name: data[i].position_name,
                province_name: data[i].province_name,
                city_name: data[i].city_name
            )
            
            
            // 得到最小的id
//            if HomepostMinId == 0 {
//                HomepostMinId = data[i].id
//            } else {
//                if HomepostMinId > data[i].id{
//                    HomepostMinId = data[i].id
//                }
//            }
//
//            // 得到最大的id
//            if HomepostMaxId == 0 {
//                HomepostMaxId = data[i].id
//            } else {
//                if HomepostMaxId < data[i].id{
//                    HomepostMaxId = data[i].id
//                }
//            }
//            print("初始化 - HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")
            
            
            post.append(item)
            

        }
        models = [MyPublish]() // 使用完清除数据
        Homeposts.append(contentsOf: post) //.append(contentsOf: post)
        
        (HomepostMinId,HomepostMaxId) = getHomePostMaxMinId ()
        print("HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")
        
        
//        print("HomepostId:" + String(HomepostMinId))

    }
    
    // 新增
    func createItem(post:RevPost)  {
        let newItem = MyPublish(context: context)
        newItem.id = post.id
        newItem.user_id = post.user_id
        newItem.user_name = post.user_name
        newItem.nick_name = post.nick_name
        newItem.publish_text = post.publish_text
        newItem.status = post.status
        newItem.reply_count = post.reply_count
        newItem.like_count = post.like_count
        newItem.company_name = post.company_name
        newItem.created_at = post.created_at
        newItem.updated_at = post.updated_at
//        newItem.is_like = post.is_like
//        newItem.is_focus = post.is_focus
        newItem.department_name = post.department_name
        newItem.group_name = post.group_name
        newItem.position_name = post.position_name
        newItem.province_name = post.province_name
        newItem.city_name = post.city_name
        
        try? context.save()

    }
    
    // 删除
    func deleteItem(item: MyPublish)  {
        
    }
    
    // 更新
    func updateItem(item: MyPublish) {
 
    }
    
    // 得到post数据id为？？
//    func getItemById(id:Int)  {
//        print("得到post数据id为")
////        do {
////
////            let request = MyPublish.fetchRequest() as NSFetchRequest<MyPublish>
////            let pred = NSPredicate(format: "id == \(id)")
////            request.predicate = pred
////            modelOne = try context.fetch(request)
////        }
////        catch {
////
////        }
////
////        print(modelOne)
//        print("PostId" + String(id))
//        
//        var postDic:[Int64:Int64] = [:] //id: index
//        for i in 0 ..< Homeposts.count {
//        let post = Homeposts[i]
//            postDic[post.id] = Int64(i)
//        }
//
//        print("postDic:")
//        print(postDic)
//        if let index = postDic[Int64(id)] {
//            self.CheckPosts = Homeposts[Int(index)]
//        }
//        
//        
//         
////        for m in modelOne {
////            let item:Post = Post(
////                id: m.id,
////                user_id: m.user_id,
////                user_name: m.user_name!,
////                nick_name: m.nick_name!,
////                publish_text: m.publish_text!,
////                status: m.status,
////                reply_count: m.reply_count,
////                like_count: m.like_count,
////                created_at: m.created_at!,
////                updated_at: m.updated_at!,
////                company_name: m.company_name!,
////                is_like: m.is_like,
////                is_focus: m.is_focus,
////                department_name: m.department_name!,
////                group_name: m.group_name!,
////                position_name: m.position_name!,
////                province_name: m.province_name!,
////                city_name: m.city_name!
////            )
////
////            self.CheckPosts = item
////
////        }
//
//    }
    
    // 关注列表
    func getFocusPublish() {
        print("关注列表")
        let postsParameter = PostsParameter(flag: "null", token: CurrentUserInfo.token, publishId: 0)
        NetworkAPI.FocusPublishPosts(paramters: postsParameter) { result in
            switch result {
            case let .success(re): self.dealFocusData(myData: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
    }
    
    
    func dealFocusData(myData: [FocusPost])  {
        print("处理关注的数据")
        print(myData)
        var tmpfocusPost:[Post] = [Post]()
        for i in  0 ..<  myData.count {

            let post  = Post(id: myData[i].id,
                 user_id: myData[i].user_id,
                 user_name: myData[i].user_name,
                 nick_name: myData[i].nick_name,
                 publish_text: myData[i].publish_text,
                 status: myData[i].status,
                 reply_count: myData[i].reply_count,
                 like_count: myData[i].like_count,
                 created_at: myData[i].created_at,
                 updated_at:  myData[i].updated_at,
                 company_name: myData[i].company_name,
                 is_like: false,
                 is_focus: true,
                 department_name: myData[i].department_name,
                 group_name: myData[i].group_name,
                 position_name: myData[i].position_name,
                 province_name: myData[i].province_name,
                 city_name: myData[i].city_name
            )
            
           
            
            tmpfocusPost.append(post)
        }
        
        
        HomefocusPublishPosts = tmpfocusPost
        
        // is_like
        for i in 0 ..< HomefocusPublishPosts.count {
            print("myLikePostId:")
            print( MyLikePostId)
            
            print("HomefocusPublishPosts:")
            print( HomefocusPublishPosts)
            
            if MyLikePostId.contains(HomefocusPublishPosts[i].id) {
                HomefocusPublishPosts[i].is_like = true
            }
        }

//        var last:Int64 = 0
//        var first:Int64 = 0
        (HomepostMinId,HomepostMaxId) = getHomePostMaxMinId ()
        print("HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")
//        focusSortPost()
        
        
        lastId = Int(HomepostMinId)
        firstId = Int(HomepostMaxId)
        
        
        
    }
    

    
    // 我喜欢的文章
    func getUserLikePublish() {
        print("我喜欢的文章")
        let token = Token( token: CurrentUserInfo.token)
        NetworkAPI.MyLikePublish(paramters: token) { result in
            switch result {
            case let .success(re): self.dealMyLikePublish(publishIds: re.data)
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
    }
    
    func dealMyLikePublish(publishIds : [Int64])  {
        print("登陆后打印用户喜欢的文章")
        MyLikePostId = publishIds
        
        print(MyLikePostId)
        for i in 0 ..< Homeposts.count  {
             
            if MyLikePostId.contains(Homeposts[i].id) {
                Homeposts[i].is_like = true
            }
             
        }
        print("我喜欢的文章 - 结束")
    }
    
    func cancelMyLikeFocusPublish()  {
        for i in 0 ..< Homeposts.count  {
            Homeposts[i].is_like = false
            Homeposts[i].is_focus = true
        }
    }
    
    func getLastDataHomePost() {
        
    }
    
    func getReplyList(publish_id:Int64) -> [ReplyData] {
        print("getReplyList")
        var replyData: [ReplyData] = [ReplyData]()
        let publishReply = PublishReply( publish_id: publish_id)
        NetworkAPI.publishReply(paramters: publishReply) { result in
            switch result {
            case let .success(re): replyData = re.data
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
        return replyData
    }
    
    // 拉取老数据
    func getOldHomePosts()  {
        print("最小的id"+String(HomepostMinId))
 
        do {

            let request = MyPublish.fetchRequest() as NSFetchRequest<MyPublish>
            let pred = NSPredicate(format: "id < \(HomepostMinId)") // HomepostMinId一定是要当前列表显示的对小id
            request.predicate = pred
            request.fetchOffset = 0
            request.fetchLimit = 5
            
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            let sortDescriptors = [sortDescriptor]
            request.sortDescriptors = sortDescriptors
 
            models = try context.fetch(request)
        }
        catch {

        }
        
        print("coredata得到的数据条数：\(models.count)")
         
        
        print("-------------------------------------------")
        if models.count == 0 {
            print("Core Data 等于0，网络请求")
            let postsParameter = PostsParameter(flag: "last", token: CurrentUserInfo.token, publishId: HomepostMinId)
            NetworkAPI.Posts(paramters: postsParameter) { result in
                switch result {
                case let .success(re): self.displyData(myData: re.data)
                case let .failure(error): _ = error.localizedDescription
                }
            }
        } else {
            print("Core Data 小于5条，不网络请求")
              
            //从coredata拿到的数据显示在页面上，但是回复数和喜欢数没有和网络同步，需要收集当前postid发送到服务端去获取最新的数据，显示在页面上
            var postIds:[Int64] = [Int64]()
            
            for i in 0 ..< models.count {
                print("id:\(models[i].id), txt:\(String(describing: models[i].publish_text))")
                
                let x = postIds.firstIndex(where: {$0 == models[i].id})
                if x == nil {
                    postIds.append(models[i].id)
                }
                
            }
            
            // 请求网络，获取 回复数和喜欢数
            
            let postId = PostIds(  token: self.CurrentUserInfo.token, post_ids: postIds)
            NetworkAPI.updatePostReplyLike(paramters: postId) { result in
                switch result {
                case let .success(re): self.dealReplyLikeCount( replylike: re.data)
                case let .failure(error): _ = error.localizedDescription
                }
            }
             

            
            
        }
    }
    
    
    // 更新回复和喜欢数
    func dealReplyLikeCount(replylike: [ReplyLikeData])  {
        print("遍历coredata数据，并且更新最新的回复和喜欢数")

        for i in 0 ..< models.count {
            print("-----------------------\(i)---------------------------")
            print("id:\(models[i].id), txt:\(String(describing: models[i].publish_text))")
            
            // 判断id不存在继续执行
            let hIndex = Homeposts.firstIndex(where: {$0.id == models[i].id})
            if hIndex == nil {
                 
                var islike = false
                if MyLikePostId.contains(models[i].id){
                    islike = true
                }
                
                var reply_num:Int64 = 0
                var like_num:Int64 = 0
                var is_focus:Bool = false
                (reply_num, like_num, is_focus) = getPostReplyLikeCount(id: models[i].id, replylike: replylike)

                let post = Post( id: models[i].id,
                                 user_id: models[i].user_id,
                                 user_name: models[i].user_name!,
                                 nick_name: models[i].nick_name!,
                                 publish_text: models[i].publish_text!,
                                 status: models[i].status,
                                 reply_count: reply_num,
                                 like_count: like_num,
                                 created_at: models[i].created_at!,
                                 updated_at: models[i].updated_at!,
                                 company_name: models[i].company_name!,
                                 is_like: islike,
                                 is_focus: is_focus,
                                 department_name: models[i].department_name!,
                                 group_name: models[i].group_name!,
                                 position_name: models[i].position_name!,
                                 province_name: models[i].province_name!,
                                 city_name: models[i].city_name!)
                
                Homeposts.append(post)
                 
            }
        }
 
        models = [MyPublish]() // 使用完清除数据
        
        (HomepostMinId,HomepostMaxId) = getHomePostMaxMinId ()
        print("HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")
        
        print("===============结束===============")
    }
    
    
    func getPostReplyLikeCount(id:Int64, replylike: [ReplyLikeData]) -> (reply_num:Int64, like_num:Int64, is_focus:Bool) {
//        print("拉取最新的喜欢、回复数据")
        var reply_num:Int64 = 0
        var like_num:Int64 = 0
        var is_focus:Bool = false
        for i in 0 ..< replylike.count {
            if replylike[i].id == id {
                reply_num = Int64(replylike[i].PostReplyLike.reply_num)
                like_num = Int64(replylike[i].PostReplyLike.like_num)
                is_focus = replylike[i].PostReplyLike.is_focus
                continue
            }
            
        }
        return (reply_num,like_num, is_focus)
    }
    
    func getHomePostMaxMinId () -> (homepostMinId:Int64, homepostMaxId:Int64) {
        print("获取最新的最小、最大编号")
        var minId:Int64 = 0
        var maxId:Int64 = 0
        
        for i in 0 ..< Homeposts.count {
            // 得到Homeposts最小的id
            if minId == 0 {
                minId = Homeposts[i].id
            } else {
                if minId > Homeposts[i].id{
                    minId = Homeposts[i].id
                }
            }
            
            // 得到Homeposts最大的id
            if maxId == 0 {
                maxId = Homeposts[i].id
            } else {
                if maxId < Homeposts[i].id{
                    maxId = Homeposts[i].id
                }
            }
        }
        return (minId,maxId)
        
    }
    
    // 更新推荐列表的回复数，在回复页面
    func updatePostReplyNum(postId: Int64)  {
         print("PostId" + String(postId))
        var postDic:[Int64:Int] = [:] //id: index
        for i in 0 ..< Homeposts.count {
            let post = Homeposts[i]
            postDic[post.id] = i
        }

        if let index = postDic[postId] {
            Homeposts[index].reply_count += 1
        }

    }
    
    // 更新推荐列表的喜欢，在列表页面
    func updatePostLikeNum(postId: Int64, state:Int)  {
         print("PostId" + String(postId))
        var postDic:[Int64:Int] = [:] //id: index
        for i in 0 ..< Homeposts.count {
            let post = Homeposts[i]
            postDic[post.id] = i
        }

        if let index = postDic[postId] {
            Homeposts[index].like_count += 1
        }

    }
    
    // 推荐 回复数更新
    func updatePostFocusReplyNum(postId: Int64)  {
         print("PostId" + String(postId))
        var postDic:[Int64:Int] = [:] //id: index
        for i in 0 ..< HomefocusPublishPosts.count {
            let post = HomefocusPublishPosts[i]
            postDic[post.id] = i
        }

        if let index = postDic[postId] {
            HomefocusPublishPosts[index].reply_count += 1
        }

    }
    
    // 获取最新推荐数据
    func getNewPost() {
        print("获取最新推荐数据,最大的id"+String(HomepostMaxId))
        // 从第几页开始显示
        // 通过这个属性实现分页
        //request.fetchOffset = 0;
        // 每页显示多少条数据
        //request.fetchLimit = 6;
//        print("0 - models:")
      
        var coreDataNewModels = [MyPublish]()
        do {
            let request = MyPublish.fetchRequest() as NSFetchRequest<MyPublish>
            let pred = NSPredicate(format: "id > \(HomepostMaxId)")
            request.predicate = pred
            request.fetchOffset = 0
            request.fetchLimit = 5
            
            coreDataNewModels = try context.fetch(request)
        }
        catch {

        }
        print("coreDataNewModels.count: \(coreDataNewModels.count)")
        
        if coreDataNewModels.count == 0 {
            print("Core Data 都完全显示，请求网络")
            let postsParameter = PostsParameter(flag: "first", token: CurrentUserInfo.token, publishId: HomepostMaxId)
            NetworkAPI.Posts(paramters: postsParameter) { result in
                switch result {
                case let .success(re): self.displyLastData(myData: re.data)
                case let .failure(error): _ = error.localizedDescription
                }
            }
        } else {
            print("Core Data 小于5条，不网络请求")
            var newPost:[Post] = [Post]()
            
            print("coreDataNewModels:")
            print(coreDataNewModels)
            for i in 0 ..< coreDataNewModels.count {
                print("id:\(coreDataNewModels[i].id), txt:\(String(describing: coreDataNewModels[i].publish_text))")
                let post:Post = Post(
                    id: coreDataNewModels[i].id,
                    user_id: coreDataNewModels[i].user_id,
                    user_name: coreDataNewModels[i].user_name!,
                    nick_name: coreDataNewModels[i].nick_name!,
                    publish_text: coreDataNewModels[i].publish_text!,
                    status: coreDataNewModels[i].status,
                    reply_count: coreDataNewModels[i].reply_count,
                    like_count: coreDataNewModels[i].like_count,
                    created_at: coreDataNewModels[i].created_at!,
                    updated_at: coreDataNewModels[i].updated_at!,
                    company_name: coreDataNewModels[i].company_name!,
                    is_like: coreDataNewModels[i].is_like,
                    is_focus: coreDataNewModels[i].is_focus,
                    department_name: coreDataNewModels[i].department_name!,
                    group_name: coreDataNewModels[i].group_name!,
                    position_name: coreDataNewModels[i].position_name!,
                    province_name: coreDataNewModels[i].province_name!,
                    city_name: coreDataNewModels[i].city_name!
                )
                
                // 得到最小的id
                if HomepostMinId == 0 {
                    HomepostMinId = coreDataNewModels[i].id
                } else {
                    if HomepostMinId > coreDataNewModels[i].id{
                        HomepostMinId = coreDataNewModels[i].id
                    }
                }
                
                // 得到最大的id
                if HomepostMaxId == 0 {
                    HomepostMaxId = coreDataNewModels[i].id
                } else {
                    if HomepostMaxId < coreDataNewModels[i].id{
                        HomepostMaxId = coreDataNewModels[i].id
                    }
                }
                print("HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")
                newPost.append(post)
            }
            
            coreDataNewModels = [MyPublish]()
//            newPost = [MyPublish]() // 使用完清除数据
//            Homeposts = post //.append(contentsOf: post)
            
            Homeposts.insert(contentsOf: newPost, at: 0)
        }
        
    }
    
    func displyLastData(myData: [RevPost]) {
        print("初始化-1 数量：\(myData.count)")

        // 1.写进coredata
        for i in 0 ..< myData.count {
            self.createItem(post: myData[i])
        }

        print("结束")
        
        // 2.写进全局变量
        getLastCoreDataToModel( data: myData)
    }
    
    // 从服务器获取数据写到coredata中
    func getLastCoreDataToModel(data:[RevPost]) {
        print("从服务器获取数据写到coredata中")
//        print("初始化 - 2 打印models数据：")
         
       
//        do {
//            self.models = try self.context.fetch(MyPublish.fetchRequest())
//            // 做动作
//
//        }
//        catch {
//
//        }
//        print(self.models)
//
//        print("---------------------------------------------------------------------------------------")
        
        lastCoreDataSyncToHomePosts( data: data)
    }
    
    // Core Data 同步到 HomePosts
    func lastCoreDataSyncToHomePosts( data:[RevPost]) {
        print("初始化 - 3 同步到HomePosts")
        var post:[Post] = [Post]()
        
        print("models:")
        print(data)
        for i in 0 ..< data.count {
            print("即将加入的数据 id:\(data[i].id), txt:\(String(describing: data[i].publish_text)), province_name:\(String(describing: data[i].province_name))")
            let item:Post = Post(
                id: data[i].id,
                user_id: data[i].user_id,
                user_name: data[i].user_name,
                nick_name: data[i].nick_name,
                publish_text: data[i].publish_text,
                status: data[i].status,
                reply_count: data[i].reply_count,
                like_count: data[i].like_count,
                created_at: data[i].created_at,
                updated_at: data[i].updated_at,
                company_name: data[i].company_name,
//                is_like: data[i].is_like,
//                is_focus: data[i].is_focus,
                department_name: data[i].department_name,
                group_name: data[i].group_name,
                position_name: data[i].position_name,
                province_name: data[i].province_name,
                city_name: data[i].city_name
            )

            // 得到最小的id
            if HomepostMinId == 0 {
                HomepostMinId = data[i].id
            } else {
                if HomepostMinId > data[i].id{
                    HomepostMinId = data[i].id
                }
            }
            
            // 得到最大的id
            if HomepostMaxId == 0 {
                HomepostMaxId = data[i].id
            } else {
                if HomepostMaxId < data[i].id{
                    HomepostMaxId = data[i].id
                }
            }
            print("HomepostMinId: \(HomepostMinId), HomepostMaxId: \(HomepostMaxId)")
            post.append(item)

        }
//        models = [MyPublish]() // 使用完清除数据
//        Homeposts.insert(contentsOf: post, at: 0) //.append(contentsOf: post)
        print("Homeposts:")
        print(Homeposts)
        print("HomepostId:" + String(HomepostMinId))
        Homeposts.insert(contentsOf: post, at: 0)
    }
    
    // 关注动作
    func focus(postId:Int64) {
        print("关注动作")
        // 1.把文章的id发送到服务端
        let focusUser = FocusPublish(token: CurrentUserInfo.token, publish_id: postId)
        NetworkAPI.focusPost(paramters: focusUser) { result in
            switch result {
            case let .success(re):   _ = (re) // MyFocusPostId
            case let .failure(error): _ = error.localizedDescription
            }
        }
//        
//        // 2.当前的数据文章写入HomefocusPublishPosts
//       

//        
        
        print("关注动作 - 结束")
    }
    
    //    获取我关注的文章编号
    func getUserFocusPublish() {
        print("获取我关注的文章编号:")
        let myFocusPublish = MyFocusPublish(token: CurrentUserInfo.token)
        NetworkAPI.MyfocusPostId(paramters: myFocusPublish) { result in
            switch result {
            case let .success(re):   self.dealFocusPostId(ids: re.data) // MyFocusPostId
            case let .failure(error): _ = error.localizedDescription
            }
        }

    }
    
    func dealFocusPostId(ids:[Int64]) {
        print("dealFocusPostId")
        MyFocusPostId = ids
        
        print("MyFocusPostId:")
        print(MyFocusPostId)
        
        for i in 0 ..< Homeposts.count {
            if MyFocusPostId.contains(Homeposts[i].id )  {//Homeposts[i].is_focus
                Homeposts[i].is_focus = false
            }
        }
        
        
    }
    
    
    // 获取索引值
//    func getHomepostsIndex(postId:Int64)  ->  (Int) {
//        var vid:Int = 0
//        print("postId:\(postId)")
//        for i in 0 ..< Homeposts.count {
//            print(Homeposts[i].id)
//            if postId == Homeposts[i].id  {
//                vid = i
//                break
//            }
//        }
//
//        return vid
//    }
    
    // 取消关注动作
    func cancleFocus(postId:Int64) {
        print("取消关注动作")
        // 1.把文章的id发送到服务端
        let focusUser = FocusPublish(token: CurrentUserInfo.token, publish_id: postId)
        NetworkAPI.cancelFocusUser(paramters: focusUser) { result in
            switch result {
            case let .success(re):   _ = (re) // MyFocusPostId
            case let .failure(error): _ = error.localizedDescription
            }
        }
        
        // 2.当前的数据文章写入HomefocusPublishPosts
//        var postIndex:Int {
//            Homeposts.firstIndex (where :{$0.id == postId}) ?? 0
//        }
//
//        HomefocusPublishPosts.append(Homeposts[postIndex])

    }
    
    // 关注页面刷新
    func getFocusRefrshData()  {
        // 1. 去服务拉去最新的关注
//        getUserFocusPublish()
        
        // 2.更新 推荐页面 的关注按钮 拉去用户关注的编号
//        getUserFocusPublish()
         
        
        
       
    }
    
    func delHomefocusPublishPosts(postId:Int64)  {
        print("删除关注：\(postId)")
//        let index = HomefocusPublishPosts.firstIndex(where: { $0.id == postId })
                
//        if index != nil {
//            HomefocusPublishPosts.remove(at: index!)
//        }
        print(HomefocusPublishPosts)
        
        cancleFocus(postId: postId) // appData.focus(postId: post.id)
//        for i in 0 ..< HomefocusPublishPosts.count {
//            if  postId == HomefocusPublishPosts[i].id {
//                HomefocusPublishPosts.remove(at: i)
//                break
//            }
//        }
    }
    
    func updateHomePostFocus(postId:Int64) {
        print("更新推荐列表的关注列表:")
        print(MyFocusPostId)
        for i in 0 ..< Homeposts.count {
            print("Homeposts[i].id : \(Homeposts[i].id)")
            if postId == Homeposts[i].id  {
                Homeposts[i].is_focus = true
                break
            }
        }
        print(MyFocusPostId)
    }
    
    // 目标更新关注列表
    func updateFocusPostLike(postId:Int64,isLike:Bool) {
        print("目标更新关注列表")
        print("更新前：")
        print(MyLikePostId)
        if isLike {
            print("true")
            MyLikePostId.append(postId)
            
        } else {
            print("false")
            let pindex = MyLikePostId.firstIndex(where :{Int($0) == Int(postId)})
            if pindex != nil {
                MyLikePostId.remove(at: pindex!)
            }
        }
        print("更新后：")
        print(MyLikePostId)
        
        let oindex = HomefocusPublishPosts.firstIndex(where: {$0.id == postId} )
        if oindex != nil {
            if isLike {

                HomefocusPublishPosts[oindex!].is_like = true
                HomefocusPublishPosts[oindex!].like_count += 1
            } else {
                HomefocusPublishPosts[oindex!].is_like = false
                HomefocusPublishPosts[oindex!].like_count -= 1
            }
        }
        
    }
    
 
    
    
    func currentTimeImg()   {
      
        let date = NSDate()
        let outputFormat = DateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US") as Locale
//        outputFormat.dateFormat = "HH:mm:ss"
        outputFormat.dateFormat = "HH"
        print(outputFormat.string(from: date as Date))
        
        let current = outputFormat.string(from: date as Date)
        let Icurrent = Int(current)!
        if Icurrent >= 0 {
            CurrentTimeImg = "moon.fill"
        } else if Icurrent >= 18 {
            CurrentTimeImg = "moon.stars.fill"
        } else if Icurrent >= 15 {
            CurrentTimeImg = "sunset.fill"
        } else if Icurrent >= 12 {
            CurrentTimeImg = "sun.max.fill"
        } else if Icurrent >= 9 {
            CurrentTimeImg = "sunrise.fill"
        } else if Icurrent >= 6 {
            CurrentTimeImg = "sun.dust.fill"
        }
        
    }
    
    func myPublishList() {
        print("我的发布")
         
        let parameter = MyFocusParameter(  token: CurrentUserInfo.token)
        NetworkAPI.mypublish(paramters: parameter) {  result in
            switch result {
            case let .success(re):  self.dealMyPublishList(data: re.data)
            case let .failure(error):  print("------");print(error.localizedDescription);print("------");
            }
        }
         
    }
    
    func dealMyPublishList(data:[MyPulishEntity])  {
        print("请求数据：")
        print(data)
        myPulishEntity = data
    }
    
    // 举报Post请求
    func reportPost(reportType:Int, postId: Int64) {
        let parameter = EntityreportPost(token: CurrentUserInfo.token, reportType: reportType, postId: postId )
        NetworkAPI.reprotPost(paramters: parameter) {  result in
            switch result {
            case let .success(re):   _ = re.data
            case let .failure(error):  _ = error.localizedDescription
            }
        }
    }
    
    // 举报按钮
    func report(type:Int, postId: Int64) {
// 色情
// 政治敏感
// 广告
// 违纪违法
// 屏蔽
// 关注
// 取消关注
        

        // 关注列表 HomefocusPublishPosts
        // 推荐列表 Homeposts

        if type == 1 {
            // 色情
            print("色情 id:\(postId)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.reportPost(reportType: type, postId: postId)
            }
        } else if type == 2 {
            // 政治敏感
            print("政治敏感 id:\(postId)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.reportPost(reportType: type, postId: postId)
            }
        } else if type == 3 {
            // 广告
            print("广告 id:\(postId)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.reportPost(reportType: type, postId: postId)
            }
        } else if type == 4 {
            // 违纪违法
            print("违纪违法 id:\(postId)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.reportPost(reportType: type, postId: postId)
            }
        } else if type == 5 {
            // 屏蔽
            print("屏蔽 id:\(postId)")
            // 关注列表 HomefocusPublishPosts
            
            // 推荐列表 Homeposts
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let hIndex = self.Homeposts.firstIndex(where: {$0.id == postId})
                if hIndex != nil {
                    self.Homeposts.remove(at: hIndex!)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let fIndex = self.HomefocusPublishPosts.firstIndex(where: {$0.id == postId})
                if fIndex != nil {
                    self.HomefocusPublishPosts.remove(at: fIndex!)
                }
            }
            
            
        } else if type == 6 {
            // 关注
            if CurrentUserInfo.token != "" {
                
                print("关注 id:\(postId)")
                
                // 关注列表 HomefocusPublishPosts
                
                // 推荐列表 Homeposts
                let hIndex = Homeposts.firstIndex(where: {$0.id == postId})
                if hIndex != nil {
                    let fIndex = HomefocusPublishPosts.firstIndex(where: {$0.id == postId})
                    if fIndex == nil {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.HomefocusPublishPosts.append(self.Homeposts[hIndex!])
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.focus(postId: postId)
                    }
                    
                }
            }

        } else if type == 7 {
            // 取消关注
            print("取消关注 id:\(postId)")
            
            // 关注列表 HomefocusPublishPosts
            
            // 推荐列表 Homeposts
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let fIndex = self.HomefocusPublishPosts.firstIndex(where: {$0.id == postId})
                if fIndex != nil {
                    self.HomefocusPublishPosts.remove(at: fIndex!)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let myFocusPostId = self.MyFocusPostId.firstIndex(where :{$0 == postId})
                if myFocusPostId != nil {
                     self.MyFocusPostId.remove(at: myFocusPostId!)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.updateHomePostFocus(postId: postId)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.cancleFocus(postId: postId)
            }
            
        } else if type == 8 {
            // 屏蔽该用户的所有数据
            let uIndex = self.Homeposts.firstIndex(where: {$0.id == postId})
            let userId = self.Homeposts[uIndex!].user_id
            
            if userId > 0 {
                // 关注列表 HomefocusPublishPosts
                
                // 推荐列表 Homeposts
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    for h in self.Homeposts  {
                        if h.user_id == userId {
                            let hIndex = self.Homeposts.firstIndex(where: {$0 == h})
                            self.Homeposts.remove(at: hIndex!)
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for f in self.HomefocusPublishPosts  {
                        if f.user_id == userId {
                            let hIndex = self.HomefocusPublishPosts.firstIndex(where: {$0 == f})
                            self.HomefocusPublishPosts.remove(at: hIndex!)
                        }
                    }

                }
            }

        }
    }
    
}
