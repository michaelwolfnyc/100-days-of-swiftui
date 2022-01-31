//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Michael Wolf on 1/30/22.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            Image(systemName: "1.circle")
        case 2:
            Image(systemName: "2.circle")
        case 3:
            Image(systemName: "3.circle")
        case 4:
            Image(systemName: "4.circle")
        default:
            Image(systemName: "5.circle")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
