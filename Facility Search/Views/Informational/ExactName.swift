//
//  ExactName.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/3/21.
//

import SwiftUI

struct ExactNameView: View {
    var selectedName: String
    
    
    var body: some View {
        VStack {
            Text("  This type of facility requires an exact name match.  The format for this search is last name, first name and may (or may not) include the term: Family Child Care Home.")
            Text("")
            Text("If you are not sure of the exact name, you can contact:")
            HStack{
                Text(" ")
                VStack(alignment: .leading) {
                    Text(" the facility directly")
                    Link(" the State Licensing Office", destination: URL(string: "https://cdss.ca.gov/inforesources/community-care-licensing")!)
                    Text(" the Resource and Referral Network:")
                    Link("   http://www.rrnetwork.org/find_child_care", destination: URL(string: "http://www.rrnetwork.org/find_child_care")!)
                    Link("   1-800-KIDS-793", destination: URL(string: "tel:18005437793")!)
                    
                }
            }
        }
    }
    
    struct ExactNameView_Previews: PreviewProvider {
        static var previews: some View {
            ExactNameView(selectedName: "")
        }
    }
}
