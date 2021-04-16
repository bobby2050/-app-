//
//  PublicLIstView.swift
//  test
//
//  Created by 杨宇铎 on 12/9/20.
//

import SwiftUI
import UIKit

struct PublishListView: View {
    
    @EnvironmentObject var appData: AppData
    
    @Binding var chekedPost: Post
    @Binding var chekedStatus: Bool
    @Binding var personalCenterShowSheet: Bool
    
    // 举报
    @Binding var isActionSheet:Bool
    @Binding var isActionSheetPostId:Int64
    @Binding var isActionSheetFocus:Bool
    
    
    var body: some View {
        
        if appData.Homeposts.isEmpty {
            VStack {
                Spacer()
                Image(systemName: "binoculars.fill")
                    .frame(width: UIScreen.main.bounds.width)
                Text("暂时没有记录").font(.body)
                     Spacer()
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
                    
                    
                    ForEach(appData.Homeposts, id: \.self) { post in
                        NavigationLink(destination: PublishDetailView(chekedPost: post ) ) {
                            
                            PublishRowView(post: post, personalCenterShowSheet: $personalCenterShowSheet, isActionSheet:$isActionSheet, isActionSheetPostId: $isActionSheetPostId,isActionSheetFocus:$isActionSheetFocus)
                        }
                         
//                        PublishRowView(post: post, personalCenterShowSheet: $personalCenterShowSheet, isActionSheet:$isActionSheet, isActionSheetPostId: $isActionSheetPostId,isActionSheetFocus:$isActionSheetFocus)
//                            .onTapGesture {
//                                chekedPost = post
//                                chekedStatus = true
//                            }
                        
                    } 
                
                
                
                }
             }
            
            
    }
                
          
    
    }

}
