//
//  SubscribeView.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/18/21.
//

import SwiftUI

struct SubscribeView: View {
    var facilityNumber: String
    var facilityName: String
    @State var email: String = UserDefaults.standard.object(forKey: "email") as! String? ?? ""
    @State var subscribeStatus: Bool = false
    @State var status: String = "Subscribing..."
    
    var body: some View {
        Form {
            Section(header: Text("Subscribe to receive weekly alerts and updates about facility \(facilityNumber): \(facilityName)")) {
                TextField("Your Email", text: $email)
                if(subscribeStatus){
                    Text(status)
                }
                else{
                    Button(action: {
                        loadData()
                        UserDefaults.standard.set(email, forKey: "email")
                        self.subscribeStatus = true
                    }, label: {
                        Text("Subscribe")
                    }).disabled(subscribeStatus)
                }
            }
            
        }.navigationBarTitle(Text("Subscribe"))
    }
    
    func loadData(){
        DataService.shared.fetchString(apiType: .subscribe(facilityNumber, email)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                        status = "Subscribed"
                    case .failure(let error):
                        print(error)
                        status = error.localizedDescription
                }
            }
        }
    }
}


struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeView(facilityNumber: "", facilityName: "")
    }
}
