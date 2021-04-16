//
//  NetworkManger.swift
//  NetWorkDemo
//
//  Created by 杨宇铎 on 11/19/20.
//

import Foundation
import Alamofire
import KeychainSwift

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

//private let NetworkAPIBaseURL = "https://zhi.bestjan.com/"
private let NetworkAPIBaseURL = "http://127.0.0.1:8080/"

class NetworkManger {
    static let shared = NetworkManger()
    
    var user = AppData().CurrentUserInfo
     
    
    private init () {}
    
 
    // Post方式请求服务端 - 注册
    @discardableResult
    func myRequestRegisterPost(path: String, paramters: Register, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
//                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    // Post方式请求服务端 - 登陆
    @discardableResult
    func myRequestLoginPost(path: String, paramters: Login, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
//                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    
    
    
    // Post方式请求服务端 - 登陆
    @discardableResult
    func myRequestPublishPost(path: String, paramters: PublishText, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
//                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    // 请求关注话题列表
    @discardableResult
    func FocusPublishPosts(path: String, paramters: PostsParameter, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .get,
                   parameters: paramters,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    
    // 请求推荐话题列表
    @discardableResult
    func Posts(path: String, paramters: PostsParameter, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .get,
                   parameters: paramters,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    // 请求用户喜欢
    @discardableResult
    func Like(path: String, paramters: Like, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    // 关注文章id
    @discardableResult
    func focusPost(path: String, paramters: FocusPublish, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    
    // 取消关注文章id
    @discardableResult
    func cancleFocusPost(path: String, paramters: FocusPublish, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    
    // 获取我关注的文章编号
    @discardableResult
    func MyfocusPostId(path: String, paramters: MyFocusPublish, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    
    
    
    
    // 请求评论内容
    @discardableResult
    func PublishReply(path: String, paramters: PublishReply, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    
    // 更新coredata的回复数和喜欢数
    @discardableResult
    func updatePostReplyLike(path: String, paramters: PostIds, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }

    
    // 回复
    @discardableResult
    func reply(path: String, paramters: Reply, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    
    
    @discardableResult
    func mypublish(path: String, paramters: MyFocusParameter, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    // 举报
    @discardableResult
    func reprotPost(path: String, paramters: EntityreportPost, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        
        AF.request(NetworkAPIBaseURL + path ,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
        
    }
    
    
    // 请求推荐话题列表
    @discardableResult
    func MyfocusList(path: String, paramters: MyFocusParameter, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters: paramters,
                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    // 请求推荐话题列表
    @discardableResult
    func RevServerNotication(path: String, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
//                   parameters: paramters,
//                   encoder: JSONParameterEncoder.default,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    // 我喜欢的文章
    @discardableResult
    func MyLikePublish(path: String, paramters: Token, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   method: .get,
                   parameters: paramters,
                   requestModifier: { $0.timeoutInterval = 15 }
        )
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                    var userInfo = nserror.userInfo
                    userInfo[NSLocalizedDescriptionKey] = "網路連結異常！～"
                    let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                    return .failure(currentError)
                }
        }
        return .failure(error)
    }
}
