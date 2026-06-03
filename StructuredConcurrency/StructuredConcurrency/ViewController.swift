//
//  ViewController.swift
//  StructuredConcurrency
//
//  Created by Tamar Gelashvili on 03/06/2026.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        asyncStreamDemo()
    }
    
    func actorCounterDemo() async {
        let counter = ActorCounter()
        print(await counter.value)
        
        await counter.increment()
        print(await counter.value)
        
        print(counter.name)
        print(counter.description)
    }
    
    func gcdCounterDemo() {
        let counter = GCDCounter()
        counter.increment()
        print(counter.value)
    }
    
    func bankDemo() {
        Task {
            let bank = Bank()
            await bank.deposit(100)
            await bank.withdraw(50)
            print(await bank.balance)
        }
    }
    
    deinit {
        //NotificationCenter.default.removeObserver(<#T##observer: Any##Any#>, name: .deleteNotification, object: nil)
    }
}

// MARK: async stream
extension ViewController {
    func asyncStreamDemo() {
        Task {
            let stream = makeAsyncStream()
            for try await num in stream {
                print(num)
            }
        }
    }
    
    func makeAsyncStream() -> AsyncThrowingStream<Int, Error> {
        let tasks: [() async -> Int] = [first, second, third]

        return AsyncThrowingStream<Int, Error> { continuation in
            for t in tasks {
                Task {
                    let value = await t()
                    if value == 1 {
                        continuation.finish()
                        return
                    }
                    continuation.yield(value)
                }
            }
        }
    }
}

// MARK: task group
extension ViewController {
    func group() async {
        let start = Date()

        let tasks: [() async -> Int] = [first, second, third]
        
        var result: [Int] = []
        
        await withTaskGroup(of: Int.self) { group in
            for t in tasks {
                group.addTask {
                    await t()
                }
            }
            
            for await data in group {
                print(data)
                result.append(data)
            }
        }
        
        print("DONE")
        print("TIME ELAPSED", Date().timeIntervalSince(start))
    }
}


// MARK: async let
extension ViewController {
    
    func asyncLet() async { // 0.00269103050231933
        let start = Date()
        async let f = first()
        async let s = second()
        async let t = third()

        print(await f, await s, await t)
        print("TIME ELAPSED", Date().timeIntervalSince(start))
    }
    
    func withoutAsyncLet() async { // 0.010185003280639648
        let start = Date()
        let f = await first()
        let s = await second()
        let t = await third()
        
        print(f, s, t)
        print("TIME ELAPSED", Date().timeIntervalSince(start))
    }
    
    
    func first() async -> Int {
        try? await Task.sleep(nanoseconds: 1000_000)
        return 1
    }
    
    func second() async -> Int {
        try? await Task.sleep(nanoseconds: 100_000)
        return 2
    }
    
    func third() async -> Int {
        try? await Task.sleep(nanoseconds: 105_000)
        return 3
    }
}

// MARK: MainActor
extension ViewController {
    
    func mainCrashDemoSYNC() {
        DispatchQueue.global().async {
            print(Thread.isMainThread)
            print(Thread.current)
            self.runOnMainactor()
        }
    }
    
    func mainCrashDemoASYNC() {
        Task { @MyGlobalActor in
            print(Thread.isMainThread)
            print(Thread.current)
            await self.runOnMainactor()
        }
    }
    
    @MainActor
    func runOnMainactor() {
        assert(Thread.isMainThread)
        print("MAINACTOR")
        self.runOnMainactor()
    }
}

extension ViewController {
    func taskBasicsDemo() async {
        await asyncPrint(val: 0)
        
        Task.immediate(operation: {
            print("1")
        })
        
        await asyncPrintWithoutSleep(val: 2)
        
        Task {
            print("3")
            await asyncPrint(val: 4)
            print("5")
        }
        
        await asyncPrint(val: 6)
        print("DONE")
        // 0  2  (4 5)
        // 1? 3? (6 DONE)?
    }
    
    func asyncPrintWithoutSleep(val: Int) async {
        print(val)
    }
    
    func asyncPrint(val: Int) async {
        try? await Task.sleep(nanoseconds: 100_000_000)
        print(val)
    }
}

extension NSNotification.Name {
    static let deleteNotification = NSNotification.Name("deleteNotification")
}

extension ViewController {
    func notifications() {
        NotificationCenter.default.post(
            name: .deleteNotification,
            object: nil,
            userInfo: [
                "name": "GithubUserName",
                "id": 123
            ]
        )
        
        NotificationCenter.default.addObserver(
            forName: .deleteNotification,
            object: nil,
            queue: .main) { not in
                print(not.userInfo)
            }
    }
}

@globalActor
actor MyGlobalActor {
    static let shared = MyGlobalActor()
    
    private init() {}
}

actor Bank {
    var balance: Int = .zero
    
    func deposit(_ amount: Int) {
        balance += amount
    }
    
    func withdraw(_ amount: Int) async {
        guard amount > 0 && amount <= balance else { return }
        
        await withdrawServiceCall() // SUSPENSION POINT
        
        balance -= amount
    }
    
    func withdrawServiceCall() async {
        try? await Task.sleep(nanoseconds: 500000)
    }
}

actor ActorCounter {
    let name: String = "Tako"
    var value: Int = .zero
    
    func increment() {
        value += 1
    }
    
    func decrement() {
        value -= 1
    }
    
    nonisolated var description: String {
        "my name is \(name)"
    }
}

final class GCDCounter {
    private let myQueue = DispatchQueue(label: "counter", attributes: .concurrent)
    private var _value: Int = .zero
    
    var value: Int {
        myQueue.sync {
            _value
        }
    }
    
    func increment() {
        print(Thread.isMainThread)

        myQueue.sync(flags: .barrier) {
            print(Thread.isMainThread)
            self._value += 1
        }
    }
    
    func decrement() {
        myQueue.sync(flags: .barrier) {
            self._value -= 1
        }
    }
}
