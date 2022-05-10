//
//  DummyView.swift
//  ViewControllerPrototype
//
//  Created by Alexander Jährling on 03.05.22.
//

import SwiftUI

struct DummyView: View {
    @EnvironmentObject var testData: TestData
    @ObservedObject var searchParameters: SearchParameters

    var body: some View {
        List {
            Section(header: Text("Block A")) {
                Text("ABC")
                Text("DEF")
            }.textCase(.none)
            
            Section(header: Text("Block B")) {
                Text("GHI")
                Text("JKL")
            }.textCase(.none)
            
            Section(header: Text("Block C")) {
                ForEach(searchParameters.values, id: \.self) { text in
                    if searchParameters.filter.isEmpty || text.localizedCaseInsensitiveContains(searchParameters.filter) {
                        Text(text)
                    }
                }
            }.textCase(.none)
        }
        //.listStyle(.sidebar) // sections can be folded, plain optics with big section font
        //.listStyle(.inset)   // section is intended deeper than list, white background
        //.listStyle(.insetGrouped) // similar to .inset, but with structured background
        //.listStyle(.grouped)    // plain settings style
        //.listStyle(.plain)          // flat design, with gray section title
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView(searchParameters: SearchParameters(filter: "11"))
    }
}
