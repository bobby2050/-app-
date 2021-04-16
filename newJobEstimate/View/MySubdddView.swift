//
//  MySubdddView.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 1/22/21.
//

import SwiftUI

struct MySubdddView: View {
    @State private var progress = 0.5
    
    var body: some View {
        
        
         
        VStack {
            ProgressView( )
                .padding(.all, 35.0)
                .frame(width: 15.0, height: 36.0)
            Button("More", action: { progress += 0.05 })
        }
        
    }
}

struct MySubdddView_Previews: PreviewProvider {
    static var previews: some View {
        MySubdddView()
    }
}
