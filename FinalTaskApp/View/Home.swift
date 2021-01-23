//
//  Home.swift
//  FinalTaskApp
//
//  Created by Field Employee on 1/18/21.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @State var alertIsVisible = false
    
    //Fetching Data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
       
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0){
                
                HStack{
                    
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                    
                    
                    Button(action: {
                        self.alertIsVisible = true
                    }, label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 40, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                    })
                    .padding(20)
                    .alert(isPresented: $alertIsVisible, content: {
                        return Alert(title: Text("Permission to access your current location"),
                                     primaryButton: .default(Text("OK").bold()){
                                        print("print location")
                                     },
                                     secondaryButton: .destructive(Text("Cancel")))
                    })
                    
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                //Empty View
                
                if results.isEmpty{
                    
                    Spacer()
                    
                    Text("No Task!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                else{
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading, spacing: 20) {
                            
                            ForEach(results){task in
                                
                                HStack(){
                                    
                                    //MARK: need to fix the image to the selected image
//                                    Image(uiImage: UIImage(data: task.img!)!)
//                                        .resizable()
//                                        .frame(width: 40, height: 40, alignment: .center)
//                                        .padding()
                                    Image(systemName: "scissors")
                                
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        
                                        Text(task.content ?? "")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        Text(task.date ?? Date(), style: .date)
                                            .fontWeight(.bold)
                                    })
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        
                                        Button(action: {homeData.EditItem(item: task)}, label: {
                                            Text("Edit")
                                        })
                                        
                                        Button(action: {
                                            context.delete(task)
                                            try! context.save()
                                        }, label: {
                                            Text("Delete")
                                        })
                                    }
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            
            // Add Button
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
            })
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
        })
    }
}


