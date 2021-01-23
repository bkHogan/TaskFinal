//
//  HomeViewModel.swift
//  FinalTaskApp
//
//  Created by Field Employee on 1/18/21.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject{
    
    @Published var content = "type here"
    @Published var date = Date()
    @Published var img = Data()
    
    // For NewData sheet...
    @Published var isNewData = false
    
    // Checking and Updating Date
    
    // Storing Update Item
    @Published var updateItem : Task!
    let calendar = Calendar.current
    
    func checkDate()->String{
        
        if calendar.isDateInToday(date){
            
            return "Today"
        }
        else if calendar.isDateInTomorrow(date){
            return "Tomorrow"
        }
        else{
            return "Other day"
        }
    }
    
    func updateDate(value: String){
        
        if value == "Today"{date = Date()}
        else if value == "Tomorrow"{
            date = calendar.date(byAdding: .day, value: 1, to: Date())!
        }
        else{
            // do something
        }
    }
    
    func writeData(context : NSManagedObjectContext){
        
        // Updating Item
        
        if updateItem != nil{
            
            // Means Update Old Data
            updateItem.date = date
            updateItem.content = content
            updateItem.img = img
            //MARK: Data prompted
            print(updateItem.img ?? 0)
            
            try! context.save()
            
            // removing updatingItem if successful
            
            updateItem = nil
            isNewData.toggle()
            content = "type here"
            date = Date()
            img = Data()
            return
        }
        
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        newTask.img = img
        //MARK: no data
//        print(newTask.img ?? 0)
        
        // saving data
        
        do{
            try context.save()
            // success means closing view
            isNewData.toggle()
            content = "type here"
            date = Date()
            img = Data()
        }
        catch{
            print(error.localizedDescription)
        }

    }
    
    func EditItem(item: Task){
        
        updateItem = item
        //toggling the newDataView
        date = item.date!
        content = item.content!
//        img = item.img!
        isNewData.toggle()
    }
    
}
