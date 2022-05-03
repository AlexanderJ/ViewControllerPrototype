//
//  DummyView.swift
//  ViewControllerPrototype
//
//  Created by Alexander Jährling on 03.05.22.
//

import SwiftUI

struct DummyView: View {
    @ObservedObject var searchParameters: SearchParameters

    var body: some View {
        List(0..<30) {
            if "Text \($0)".contains(searchParameters.filter) {
                Text("Text \($0)")
            }
        }
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView(searchParameters: SearchParameters(filter: "11"))
    }
}
