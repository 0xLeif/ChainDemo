//
//  ContentView.swift
//  Shared
//
//  Created by Zach Eriksen on 1/12/21.
//

import SwiftUI
import Chain
import SURL

struct ContentView: View {
    @State private var text = "Hello, world!"
    
    var body: some View {
        Text(text)
            .padding()
            .onAppear {
                Chain
                    .link(reportScreenView,
                          .link(setLoadingState,
                                .background(fetchData,
                                            .end)
                          )
                    )
                    .run()
            }
    }
    
    func reportScreenView() {
        reportAnalytic(screenNamed: "Home")
    }
    
    func setLoadingState() {
        update(text: "Loading...")
    }
    
    func fetchData() {
        "https://raw.githubusercontent.com/0xLeif/0xLeif/master/README.md"
            .url?
            .get  { (data, response, error) in
                
                Chain.link({
                    update(text: String(data: data!, encoding: .utf8) ?? "😬")
                },
                .complete {
                    reportAnalytic(event: "home_data_loaded")
                })
                .run()
                
                
            }
    }
    
    func update(text value: String) {
        text = value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// MARK: Mock Functions

func reportAnalytic(event: String) { }
func reportAnalytic(screenNamed: String) { }
