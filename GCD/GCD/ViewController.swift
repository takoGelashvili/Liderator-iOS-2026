//
//  ViewController.swift
//  GCD
//
//  Created by Tamar Gelashvili on 01/06/2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        workItem()
    }
    
    func workItem() {
        var workItem: DispatchWorkItem?
        
        workItem = DispatchWorkItem {
            print("HERE")
            
            sleep(2)
            
            if workItem?.isCancelled ?? true {
                print("CANCELED")
            }
        }
        
        guard let workItem else { return }
        
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 3, execute: workItem)
        
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 4) {
            workItem.cancel()
        }
    }
    
    func semaphores() {
        let sem = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 4) {
            print("SERVICE ONE DONE")
            sem.signal()
        }
        
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 2) {
            print("SERVICE TWO DONE")
            sem.signal()
        }
        
        sem.wait()
        sem.wait()
        
        print("ALL DONE")
    }
    
    func group() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 4) {
            print("SERVICE ONE DONE")
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 2) {
            print("SERVICE TWO DONE")
            group.leave()
        }
        
        group.wait()
        print("ALL DONE")
        
//        group.notify(qos: .userInitiated, queue: .main) {
//            print("ALL DONE")
//        }
        
        print("HERE")
    }
    
    func serviceCall2() {
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 4) {
            print("SERVICE TWO DONE")
        }
    }
    
    func asyncAfterVSSleep() {
        let now = DispatchTime.now()
                
        DispatchQueue.main.async {
            sleep(4)
            print("AFTER 4 SECONDS")
        }
        
        DispatchQueue.main.asyncAfter(deadline: now + 1) {
            print("AFTER 3 SECONDS")
        }
        
        DispatchQueue.main.async {
            sleep(10)
            print("AFTER 10 SECONDS")
        }
                
        print("ALL DONE")
    }
    
    func mainSync() {
        DispatchQueue.global().async {
            assert(!Thread.isMainThread)
            
            DispatchQueue.main.sync {
                assert(!Thread.isMainThread)
                print("Hello from background thread")
            }
            
            print("HERE")
        }
    }
}

