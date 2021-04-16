//
//  MyFocusView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 1/24/21.
//

import SwiftUI
import UIKit
struct MyFocusView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        func deleteRow(at offsets:IndexSet) {
           
//            let index = offsets[offsets.startIndex]
            
//            let tid = appData.MyFocus[index].id
//            let userid = appData.MyFocus[index].user_id
            
            appData.MyFocus.remove(atOffsets:offsets)
            
 
//            let focusUser = FocusUser(token: appData.CurrentUserInfo.token, userId: tid )
//            NetworkAPI.cancelFocusUser(paramters: focusUser) { result in
//                switch result {
//                case let .success(re): _ = re.data;
//                case let .failure(error): _ = error.localizedDescription
//                }
//            }
 
            if appData.MyFocus.isEmpty {
//                appData.homefocusPostsEmpty()
            }
 
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                appData.myPublishFocusInitData(restatusInit: true)
//            }
//            appData.publishDataInit(restatusInit: false)
 
        }
        
        return VStack {
            
            Text("我的关注").font(.title).padding()
            if appData.HomefocusPublishPosts.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "binoculars.fill")
                        .frame(width: UIScreen.main.bounds.width)
                    Text("暂时没有关注记录")
                         Spacer()
                    Spacer()
                }
            } else {
                
                List{
                    ForEach(appData.HomefocusPublishPosts, id: \.id) { row in
                        HStack{
                            Text(row.company_name).font(.system(size:13))
                            Spacer()
//                            Text(row.created_at).font(.body)
                        }
                         
                    }
                    .onDelete(perform: deleteRow)
                  
                }
            }
        }
        
    }
}

struct MyFocusView_Previews: PreviewProvider {
    static var previews: some View {
        MyFocusView()
    }
}
