//
//  ExactName.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/3/21.
//

import SwiftUI

struct ExactNameView: View {
    var body: some View {
        VStack {
            Text("  This type of facility requires an exact name match.  The format for this search is last name, first name and may (or may not) include the term: Family Child Care Home.")
            Text("")
            Text("If you are not sure of the exact name, you can contact:")
            HStack{
                Text(" ")
                VStack(alignment: .leading) {
                    Text(" the facility directly")
                    Button( action: {
                        let url = URL(string: "https://cdss.ca.gov/inforesources/community-care-licensing")!
                        UIApplication.shared.open( url )
                    }) { Text(" the State Licensing Office")}
                    Button(action: {
                        let url = URL(string: "http://www.rrnetwork.org/find_child_care")!
                        UIApplication.shared.open( url)
                    }) {Text(" the Resource and Referral Network:")}
                    Button(action: {
                        let url = URL(string: "http://www.rrnetwork.org/find_child_care")!
                        UIApplication.shared.open( url)
                    }) {Text("   http://www.rrnetwork.org/find_child_care")}
                    Button(action: {
                        let url = URL(string: "tel:18005437793")!
                        UIApplication.shared.open( url)
                    }) {Text("   1-800-KIDS-793") }
                }
            }
        }
    }
    
    struct ExactNameView_Previews: PreviewProvider {
        static var previews: some View {
            ExactNameView()
        }
    }
}
