//
//  PersonalProfile.swift
//  Rino
//
//  Created by Ayman Omara on 20/06/2022.
//

import SwiftUI

import SkeletonUI
struct PersonalProfileView: View {
    @ObservedObject var viewmodel = UserProfileViewModel()
    var body: some View {
        VStack {
            if viewmodel.errorcase == .none {
                VStack{
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.orange)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200, alignment: .center)
                            
                        Text(viewmodel.data?.arabicName ?? Constents.noValue)

                        Form{
                            
                            Section {
                                ProfileItem(key: "رقم الهاتف", value: viewmodel.data?.phoneNumber ?? Constents.noValue)
                                
                            } header: {
                                Text("البيانات الشخصية")
                                
                            }
                            Section {
                                HStack{
                                    Text(viewmodel.data?.email ?? Constents.noValue)
                                }
                                
                            } header: {
                                Text("البريد الالكتروني")
                            }

                            Section {
                                ProfileItem(key: "القسم", value: viewmodel.data?.departmentArabic ?? Constents.noValue)
                            } header: {
                                Text("بيانات الوظيفة")
                            }

                        }
                                        
                    .skeleton(with: viewmodel.isLoading)
                    .shape(type: .rectangle)

            }
            .onAppear{
                viewmodel.getUserProfile()
            }
        .environment(\.layoutDirection, .rightToLeft)
            } else {
                ErrorView(action: {
                    viewmodel.getUserProfile()
                }, errorcase: viewmodel.errorcase)
            }
        }
        
    }
}

struct PersonalProfile_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
    }
}
struct ProfileItem:View{
    var key:String
    var value:String
    var body: some View{
        HStack{
            Text(key+":")
            Text(value)
                
        }
    }
    
}
