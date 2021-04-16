//
//  Post.swift
//  MyApp
//
//  Created by 杨宇铎 on 11/24/20.
//

import Foundation

// 请求话题列表实体
struct Post: Codable,Hashable, Identifiable{
    var id: Int64
    var user_id: Int64
    var user_name: String
    var nick_name: String
    var publish_text: String
    var status: Int16
    var reply_count: Int64
    var like_count: Int64
    var created_at: String
    var updated_at: String
    var company_name: String
    var is_like:Bool = false
    var is_focus:Bool = false
    var department_name:String
    var group_name:String
    var position_name:String
    var province_name:String
    var city_name:String 
}
//extension Post: Equatable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.id == rhs.id
//    }
//}

// 请求话题列表实体
struct FocusPost: Codable{
    var id: Int64
    var user_id: Int64
    var user_name: String
    var nick_name: String
    var publish_text: String
    var status: Int16
    var reply_count: Int64
    var like_count: Int64
    var created_at: String
    var updated_at: String
    var company_name: String
    var department_name:String
    var group_name:String
    var position_name:String
    var province_name:String
    var city_name:String
}
extension FocusPost: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// 注册接口
struct Register: Encodable {
    let username: String
    let password: String
    let re_password: String
    let nick_name: String
    let email: String
}


struct DataMsgRegister: Decodable {
    let code: Int
    let data: String
    let msg: String
   
}


// 登陆
struct Login: Encodable {
    let name: String
    let password: String
}

struct UserInfo: Decodable {
    let id: Int
    let user_name: String
    let password: String
    let salt: String
    let nick_name: String
    let mobile: String
    let session: String
    let created_at: String
    let updated_at: String
}

struct UserData1: Decodable {
    let UserInfo:UserInfo
    let Token:String
    
}

struct DataMsgLogin: Decodable {
    let code: Int
    let data: UserData1
    let msg: String
   
}

struct DataMsg: Decodable {
    let code: Int
    let data: String
    let msg: String
}

// 获取我关注的文章编号
struct FocusPostDataMsg: Decodable {
    let code: Int
    let data: [Int64]
    let msg: String
}


// 发送服务的文章
struct PublishText: Encodable {
    let token: String
    let companyName: String
    let departmentName: String
    let groupName: String
    let positionName: String
    let provinceName: String
    let cityName: String
    let contentText: String
}


// 登陆后的用户信息实体
struct LoginUserInfo {
    var nickName: String
    var token: String
    var user_id: Int
}




// 请求话题列表参数实体
struct PostsParameter: Encodable {
    var flag:String
    var token:String
    var publishId: Int64
    
    
    
}


struct Token: Encodable {

    var token:String
 
}

// 返回话题列表参数实体
struct FocusPostsDataMsg: Decodable {
    let code: Int
    let data: [FocusPost]
    let msg: String
}

// 返回话题列表参数实体
struct PostsDataMsg: Decodable {
    let code: Int
    let data: [Post]
    let msg: String
}


// 请求话题列表实体
struct RevPost: Codable{
    var id: Int64
    var user_id: Int64
    var user_name: String
    var nick_name: String
    var publish_text: String
    var status: Int16
    var reply_count: Int64
    var like_count: Int64
    var created_at: String
    var updated_at: String
    var company_name: String
    
    var department_name:String
    var group_name:String
    var position_name:String
    var province_name:String
    var city_name:String
}
extension RevPost: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}



// 返回话题列表参数实体
struct RevPostsDataMsg: Decodable {
    let code: Int
    let data: [RevPost]
    let msg: String
}

// 我喜欢文章
struct MyLikePublish: Decodable {
    let code: Int
    let data: [Int64]
    let msg: String
}

enum PostCategory {
    case focus, common
}

// 我喜欢文章
struct Like: Encodable {
    var token: String
    var post_id: Int64
    var state: Int
}

struct MyFocusPublish:Encodable {
    let token: String
}
struct FocusPublish:Encodable {
    let token: String
    let publish_id: Int64
}

struct PublishReply:Encodable {
   
    let publish_id: Int64
    
}

struct PostIds:Encodable {
    let token: String
    let post_ids: [Int64]
}


// 回复内容
struct ReplyData:Decodable   {
    let id : Int64
    let publish_id: Int64
    let user_id: Int
    let nick_name: String
    let reply_text: String
    let status:Int
    let created_at: String
}
//extension ReplyData: Equatable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.id == rhs.id
//    }
//}

struct DataPublishReplyMsg: Decodable {
    let code: Int
    let data: [ReplyData]
    let msg: String
}

//------ 回复和喜欢数-----

struct ReplyLikeCount: Decodable {
    let reply_num: Int
    let like_num: Int
    let is_focus: Bool
     
}

struct ReplyLikeData: Decodable {
    let id: Int
    let PostReplyLike: ReplyLikeCount
     
}

struct DataReplyLikeMsg: Decodable {
    let code: Int
    let data: [ReplyLikeData]
    let msg: String
}

//------
// 回复
struct Reply:Encodable   {
    let publish_id: Int64
    let token: String
    let reply_text: String
}

// 我的关注 返回
struct MyFocusEntity:Codable {
    let id: Int
    let user_id: Int
    let created_at: String
    let nick_name: String
    let city: String
}

struct MyFocus:Codable {
    let code: Int
    let data: [MyFocusEntity]
    let msg: String
}

// 我的关注列表参数实体 发送
struct MyFocusParameter: Encodable {
    var token:String
}

// 我的发布 返回
struct MyPulish:Codable {
    let code: Int
    let data: [MyPulishEntity]
    let msg: String
}

struct MyPulishEntity:Codable,Hashable, Identifiable {
    let id: Int
    let user_id: Int
    let user_name:String
    let nick_name:String
    let publish_text:String
    let status:Int
//    let reply_count:Int
//    let like_count:Int
    let company_name:String
    let created_at:String
    let updated_at:String
//    let is_like:Bool
//    let is_focus:Bool
    let department_name:String
    let group_name:String
    let position_name:String
    let province_name:String
    let city_name:String
    
}

// 举报
struct EntityreportPost: Encodable {
    var token:String
    var reportType:Int
    var postId:Int64
}
