//
//  UserStateView.swift
//  test
//
//  Created by 杨宇铎 on 12/17/20.
//

import SwiftUI
import KeychainSwift

struct UserStateView: View {
    @Binding var personalCenterShowSheet:Bool
    
    @Binding var userState:Int
    
    var body: some View {
        TabView (selection: $userState) {
            LoginView( personalCenterShowSheet: $personalCenterShowSheet, userState: $userState).tag(0)
            RegisterView(personalCenterShowSheet: $personalCenterShowSheet, userState: $userState).tag(1)
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

//struct UserStateView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserStateView(personalCenterShowSheet: .constant(false), loginUserInfo: .constant(.init(nickName: "", token: "")), userState: .constant(0))
//    }
//}
