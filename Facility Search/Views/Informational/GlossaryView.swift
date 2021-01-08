//
//  GlossaryView.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/4/21.
//

import SwiftUI

struct GlossaryView: View {
    @State var report = "<h1>Loading...</h1>"
    
    var body: some View {
        HTMLStringView(htmlContent: report)
            .onAppear(perform: loadData)
            .navigationTitle("Glossary")
    }
    
    func loadData(){
        DataService.shared.fetchGlossary() { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        if data.count == 0 {
                            report = "Not found"
                        } else {
                            self.report = data
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}


struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
