//
//  ArchiveMovementModificationsView.swift
//  Rino
//
//  Created by Ayman Omara on 28/06/2022.
//

import SwiftUI
import SkeletonUI
import Combine
struct ArchiveMovementModificationsView: View {
    var id:Int
    @ObservedObject var viewModel = ChnageLogViewModel()
    var body: some View {
        

        VStack{
            if viewModel.errorcase == .none{
                ScrollView(.vertical, showsIndicators: true, content: {
                    ForEach(viewModel.data){ item in
                        ChangeLogCell(item: item)
                    }
                })
            }else{
                ErrorView(action: {
                    viewModel.getChangeLog()
                }, errorcase: viewModel.errorcase)
            }
        }
        .skeleton(with: viewModel.isLoading)
        .shape(type: .rectangle)
        .onAppear{
            viewModel.id = id
            viewModel.getChangeLog()
        }


        .padding(.horizontal,5)
        

        
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct ArchiveMovementModificationsView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveMovementModificationsView(id:20)
    }
}
