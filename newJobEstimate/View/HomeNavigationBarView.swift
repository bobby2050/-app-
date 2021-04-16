//
//  HomeNavigationBarView.swift
//  test
//
//  Created by 杨宇铎 on 12/8/20.
//

import SwiftUI
import Combine
import KeychainSwift

private let klabelWidth:CGFloat = 45
private let kButtionHeight:CGFloat = 24

struct HomeNavigationBarView: View {
    @EnvironmentObject var appData: AppData
    
    @Binding var selectIndex: Int // 0 在左边，1 在右边

    @Binding var personalCenterShowSheet: Bool
//    @Binding var loginUserInfo: LoginUserInfo
    
    var body: some View {
        HStack{
            Image(systemName: appData.CurrentTimeImg)
                .resizable()
                .frame(width: 20, height: 20).padding()
                .foregroundColor(Color.white)
            
            Spacer()
            
            VStack (alignment: .leading, spacing: 3) {
                HStack(spacing:0) {
                    Text("关注")
                        .bold()
                        .frame(width: klabelWidth, height: kButtionHeight)
                        .padding(.top, 5)
                        .onTapGesture {
                            selectIndex = 0
                        }
                    
                    Text("").frame(width: klabelWidth, height: kButtionHeight)
                    
                    Text("推荐")
                        .bold()
                        .frame(width: klabelWidth, height: kButtionHeight)
                        .padding(.top, 5)
                        .onTapGesture {
//                            withAnimation(Animation.default) {
                                selectIndex = 1
//                            }
                        }
                }
                .font(.system(size: 20))
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 30, height: 4)
                    .foregroundColor(.white)
                    .offset(x:CGFloat(selectIndex * 90) + klabelWidth * 0.15)
                    .animation(.default)

            }
            .frame(width: UIScreen.main.bounds.width * 0.5)
            
            Spacer()
            
            // 头像
            Button(action:{
                print("点击头像")
                withAnimation(.spring()) {
                    self.personalCenterShowSheet = true // 头像按钮框开
                }
 
            }) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 20, height: 20).padding()
                    .foregroundColor(Color.white)
            }

            
        }
        .padding(.top)
        .background(Color.orange)
         
    }
}
 
