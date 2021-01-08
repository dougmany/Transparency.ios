//
//  FaqView.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/4/21.
//

//
//  ExactName.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/3/21.
//

import SwiftUI

struct FaqView: View {
    @State var report = "<h1>Loading...</h1>"
    
    var body: some View {
        HTMLStringView(htmlContent: report)
            .onAppear(perform: loadData)
            .navigationTitle("FAQ")
    }
    
    func loadData(){
        DataService.shared.fetchString(apiType: .faq) { (result) in
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


struct FaqView_Previews: PreviewProvider {
    static var previews: some View {
        FaqView()
    }
}
