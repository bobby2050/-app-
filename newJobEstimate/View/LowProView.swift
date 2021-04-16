//
//  LowProView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 3/4/21.
//

import SwiftUI

struct LowProView: View {
    var name:String?
    var myUrl:String?
    var body: some View {
        VStack{
            Text(name!).padding()
            SwiftUIWebView(url: URL(string: myUrl!))
        }
    }
}

 
