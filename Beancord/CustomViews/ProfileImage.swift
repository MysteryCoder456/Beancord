//
//  ProfileImage.swift
//  Beancord
//
//  Created by Rehatbir Singh on 06/22/2021.
//

import SwiftUI

struct ProfileImage: View {
    var image: UIImage
    var size: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(image: UIImage(named: "bean")!, size: 200)
    }
}
