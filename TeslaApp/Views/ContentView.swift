//
//  ContentView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var openVoiceComman = false
    @State private var openNotification = false
    @State private var title = ""
    @State private var icon = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView{
                    VStack {
                        HomeHeader()
                        Divider()
                            .background(Color.white)
                            .opacity(0.4)
                        CarView()
                        Divider()
                            .background(Color.white)
                            .opacity(0.4)
                        ActionsView(open: $openNotification, title: "Quick Shortcuts", isEdit: true, items: quickShortcuts, sTitle: $title, sIcon: $icon)
                        Divider()
                            .background(Color.white)
                            .opacity(0.4)
                        ActionsView(open: $openNotification, title: "Recent Actions", items: recentItems, sTitle: $title, sIcon: $icon)
                        Divider()
                            .background(Color.white)
                            .opacity(0.4)
                        AllSettingsView()
                        ReorderButton()
                        
                    }
                    .padding()
                    
                    
                }
                VoiceCommandButton(open: $openVoiceComman)
                if (openVoiceComman || openNotification) {
                    Color.black.opacity(0.1)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .backgroundBlur(radius: 3, opaque: true)
                        .onTapGesture {
                            withAnimation {
                                openVoiceComman = false
                                openNotification = false
                            }
                        }
                }
                if openVoiceComman {
                    
                    VoiceWidget(open: $openVoiceComman, text: "Take me to EA Mall")
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                if openNotification {
                    if (title == "Media Controls"){
                        MediaPlayerWidget()
                            .zIndex(1)
                            .transition(.move(edge: .bottom))
                    }
                    else if (title == "Charging"){
                        ChargingWidget(open: $openNotification)
                            .zIndex(1)
                            .transition(.move(edge: .bottom))
                    }
                    else {
                        ActionNotification(open: $openNotification, icon: icon, text: title)
                            .zIndex(1)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .background(Color.background)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .foregroundColor(Color.white)
            .navigationTitle("Tesla")
            .navigationBarHidden(true)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct VoiceCommandButton: View{
    
    @Binding var open: Bool
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    withAnimation {
                        open = true
                    }
                }) {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .frame(width: 64, height: 64)
                        .background(Color("Green"))
                        .foregroundColor(Color("Background"))
                        .clipShape(Circle())
                        .padding()
                        .shadow(radius: 10)
                }
            }
        }
    }
}

struct HomeHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal,8)
                    .background(Color("Red"))
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
            }
            Spacer()
            HStack{
                NavigationLink (
                    destination: LockView()
                ) {
                    
                    GeneralButton(icon: "lock.fill")
                    
                }
                NavigationLink (
                    destination: SettingsView()
                ) {
                    GeneralButton(icon: "gear")}
            }
        }
        .padding(.top)
    }
}


struct CarView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                HStack{
                    Image(systemName: "battery.75")
                    Text("237 miles".uppercased())
                }
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(Color("Green"))
                Spacer()
                VStack(alignment: .trailing){
                    Text("Parked")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Last updated 5 min ago")
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                }
                
            }
            .padding(.top)
            
            Image("car_img")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
        
    }
}

struct ActionsView: View {
    @Binding var open: Bool
    var title: String
    var isEdit: Bool = false
    var items: [ActionModel]
    
    @Binding var sTitle: String
    @Binding var sIcon: String
    var body: some View {
        VStack(alignment: .leading) {
            ActionViewHeader(title: title, isEdit: isEdit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top){
                    ForEach(items, id: \.self){ item in
                        Button(action: {
                            sTitle = item.text
                            sIcon = item.icon
                            withAnimation {
                                open = true
                            }
                        }){
                            ActionItem(icon: item.icon, text: item.text)
                        }
                    }
                    
                    
                }
            }
            
        }
    }
}


struct AllSettingsView: View {
    var body: some View {
        VStack {
            ActionViewHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(.fixed(170)),GridItem(.fixed(170))]) {
                NavigationLink(destination: ControlsView()) {
                    AllSettingsItem(icon: "car.fill", text: "Controls")}
                NavigationLink(destination:  ClimateView()) {
                    AllSettingsItem(icon: "sun.min.fill", text: "Climate", subtitle: "interior 24º C",  isActive: true)}
                NavigationLink(destination: LocationView()) {
                    AllSettingsItem(icon: "location.fill", text: "Location", subtitle: "Anna Nagar")}
                Button(action: {}){
                    AllSettingsItem(icon: "checkerboard.shield", text: "Security", subtitle: "0 EVENTS DETECTED")}
                Button(action: {}){
                    AllSettingsItem(icon: "sparkles", text: "Upgrades")}
                
            }
            
            
        }
    }
}

struct ReorderButton: View {
    var body: some View {
        Button(action: {}){
            Text("Reorder Groups")
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.white.opacity(0.1))
                .clipShape(Capsule())
        }.padding()
    }
}


struct AllSettingsItem: View {
    var icon: String
    var text: String
    var subtitle: String = ""
    var isActive: Bool = false
    var body: some View {
        
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: icon)
                .imageScale(.large)
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text(text)
                    .font(.body)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: true, vertical: false)
                if !subtitle.isEmpty {
                    Text(subtitle.uppercased())
                        .font(.system(size: 8, weight: .medium))
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
            .foregroundColor(Color.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.white)
                .opacity(0.6)
            
            
        }
        .padding(8)
        .frame(height: 70)
        .background(isActive ? Color.selectedGridBackgroud : Color.gridBackgroud, in:
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
        )
        .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 1, blendMode: .overlay)
    }
}


