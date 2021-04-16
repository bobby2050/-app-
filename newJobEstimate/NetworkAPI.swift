//

//  NetworkAPI.swift
//  NetWorkDemo
//
//  Created by 杨宇铎 on 11/23/20.
//

import Foundation
import Alamofire

class NetworkAPI {
    
//    // 推荐列表
//    @discardableResult
//    static func recommendPostList(completion: @escaping (Result<Post, Error>) -> Void) -> DataRequest {
//        NetworkManger.shared.requestGet(path: "PostListData_recommend_1.json", parameters: nil) { result in
//            switch result {
//            case let .success(data) :
//                let parseResult: Result<Post, Error> = self.parseData(data: data)
//                completion(parseResult)
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    // 热门列表
//    @discardableResult
//    static func HotPostList(completion: @escaping (Result<Post, Error>) -> Void) -> DataRequest {
//        NetworkManger.shared.requestGet(path: "PostListData_hot_1.json", parameters: nil) { result in
//            switch result {
//            case let .success(data) :
//                let parseResult: Result<Post, Error> = self.parseData(data: data)
//                completion(parseResult)
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    // 用户注册信息
    @discardableResult
    static func userRegisterSendData(paramters: Register,  completion: @escaping (Result<DataMsgRegister, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.myRequestRegisterPost(path: "v1/register", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                
                let parseResult: Result<DataMsgRegister, Error> = self.parseData(data: data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
         
    }
    
    // 用户登陆信息
    @discardableResult
    static func userLoginSendData(paramters: Login,  completion: @escaping (Result<DataMsgLogin, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.myRequestLoginPost(path: "v1/login", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                
                let parseResult: Result<DataMsgLogin, Error> = self.parseData(data: data)
                
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
         
    }
    
    
    // 发布信息
    @discardableResult
    static func userPublishSendData(paramters: PublishText,  completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.myRequestPublishPost(path: "v1/publishPost", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
         
    }
    
    
    // 关注话题列表
    @discardableResult
    static func FocusPublishPosts(paramters: PostsParameter, completion: @escaping (Result<FocusPostsDataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.FocusPublishPosts(path: "cache/listFocusPublish", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<FocusPostsDataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 推荐话题列表，最新更新全部拉去数据
    @discardableResult
    static func Posts(paramters: PostsParameter, completion: @escaping (Result<RevPostsDataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.Posts(path: "cache/list", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<RevPostsDataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                print("-----完毕解析数据-----")
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 喜欢按钮
    @discardableResult
    static func LikePost(paramters: Like, completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.Like(path: "cache/like", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 获取我关注的文章编号
    @discardableResult
    static func MyfocusPostId(paramters: MyFocusPublish, completion: @escaping (Result<FocusPostDataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.MyfocusPostId(path: "cache/myfocusPostId", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<FocusPostDataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 请求关注文章
    @discardableResult
    static func focusPost(paramters: FocusPublish, completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.focusPost(path: "cache/focusPublish", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    

    
    
    // 请求取消关注用户
    @discardableResult
    static func cancelFocusUser(paramters: FocusPublish, completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.cancleFocusPost(path: "cache/cancelFocusPublish", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 请求评论内容
    @discardableResult
    static func publishReply(paramters: PublishReply, completion: @escaping (Result<DataPublishReplyMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.PublishReply(path: "cache/publishReply", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataPublishReplyMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 更新coredata的回复数和喜欢数
    @discardableResult
    static func updatePostReplyLike(paramters: PostIds, completion: @escaping (Result<DataReplyLikeMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.updatePostReplyLike(path: "cache/postReplyLikeCount", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataReplyLikeMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    
    // 请求评论内容
    @discardableResult
    static func MyfocusList(paramters: MyFocusParameter, completion: @escaping (Result<MyFocus, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.MyfocusList(path: "v1/myfocus", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<MyFocus, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 请求评论内容
    @discardableResult
    static func RevServerNotication(completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.RevServerNotication(path: "v1/serverNotication") { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 请求评论内容
    @discardableResult
    static func reply(paramters: Reply, completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.reply(path: "cache/reply", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 请求评论内容
    @discardableResult
    static func mypublish(paramters: MyFocusParameter, completion: @escaping (Result<MyPulish, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.mypublish(path: "cache/mypublish", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<MyPulish, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 举报
    @discardableResult
    static func reprotPost(paramters: EntityreportPost, completion: @escaping (Result<DataMsg, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.reprotPost(path: "cache/reprotPost", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<DataMsg, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    // 关注话题列表
    @discardableResult
    static func MyLikePublish(paramters: Token, completion: @escaping (Result<MyLikePublish, Error>) -> Void) -> DataRequest {
        NetworkManger.shared.MyLikePublish(path: "cache/myPublishLike", paramters: paramters) { result in
            
            switch result {
            case let .success(data):
                print("-----开始解析数据-----")
                let parseResult: Result<MyLikePublish, Error> = self.parseData(data: data)
                completion(parseResult)
                
            case let .failure(error):
                completion(.failure(error))
                
            }
            
        }
         
    }
    
    
    
    
    // 解析数据
    private static func parseData<T:Decodable> (data: Data) -> Result<T,Error> {
        
         
//        guard let decodeData1 = try? JSONDecoder().decode(DataMsg.self, from: data) else {
//            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Can net parse data"])
//            return .failure(error)
//        }
//        print(decodeData1.code)
//        if decodeData1.code != 10000 {
//
//        }
        
        
 
         
        
        guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Can net parse data"])
            return .failure(error)
        }
        return .success(decodeData)
        
    }
}
