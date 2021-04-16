//
//  MyPublishView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 1/24/21.
//

import SwiftUI

struct MyPublishView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack{
            Text("我发布的记录").padding()
            if appData.myPulishEntity.isEmpty { //            if appData.myPulishEntity.count == 0 {
                Text("记录为空").font(.system(size: 12))
            } else {
                
                List {
                    ForEach(appData.myPulishEntity, id: \.self) { row in
                        HStack{
                            Text("公司名称 \(row.company_name) ")
                            Spacer()
                            Text(" \(row.created_at)")
                        }
                        
                            .font(.system(size: 12))
                    }.shadow(radius: 5)
                }
            }
        }.onAppear{
            print(appData.myPulishEntity)
        }
        
    }
}
