//
//  PublishDetailReplyView.swift
//  test
//
//  Created by 杨宇铎 on 12/4/20.
//

import SwiftUI

struct PublishDetailReplyView: View {
    var replyData: ReplyData
//    var chekedPost:Posts
    @State private var showingSheet = false
    
    var body: some View {
        if replyData.status == 0 {
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)

                    VStack(alignment: .leading){
                        
                        Text(replyData.nick_name)
                            
                            .font(.system(size: 14.0))
                            .fontWeight(.thin)
                            .frame(height: 40)

                        Text("\(replyData.reply_text)")
                            .strikethrough(true, color: Color.red)
                            .lineLimit(nil)
                            .frame(width: UIScreen.main.bounds.width * 0.75,alignment: .leading)
                            .font(.system(size: 12.0))
                            .lineSpacing(6)
//                        Text("Text strikethrough red")
                                
//                            .strikethrough(true, color: Color.gray)
                             
                        
                        Text("未审核")
                            .frame(height: 40)
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .rotationEffect(.degrees(-22))

                    }
                    
                }
                
            }
        } else {
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)

                    VStack(alignment: .leading){
                        
                        Text(replyData.nick_name)
                            
                            .font(.system(size: 14.0))
                            .fontWeight(.thin)
                            .frame(height: 40)

                        Text("\(replyData.reply_text)")
                            .frame(width: UIScreen.main.bounds.width * 0.75,alignment: .leading)
                            .font(.system(size: 12.0))
                            .lineSpacing(6)
                        
                        Text("\(replyData.created_at)")
                            .frame(height: 40)
                            .font(.system(size: 10.0))
                            .foregroundColor(.gray)

                    }
                    
                }
                
            }
        }
        
        
    }
}
 
