//
//  ViewController.swift
//  RXPractice
//
//  Created by 이한목 on 2021/09/10.
//

import UIKit
//import RxCocoa
import RxSwift
import RxRelay

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        dummy()
        //        example2()
        //        example3()
        //        example4()
        //        rangeExample()
//        disposingAndTerminating()
        disposeBag()
        // Do any additional setup after loading the view.
    }
    
    /*
     func changeOrientation() {
     UIDevice.rx.orientation
     .subscribe(onNext: { current in
     switch current {
     case .landscape:
     ... re-arrange UI for landscape
     case .portrait:
     ... re-arrange UI for portrait
     }
     })
     }
     */
    
    /*
     func changeOrientation2() {
     UIDevice.rx.orientation
     .filter { value in
     return value != .landscape
     }
     .map { in
     return "Portrait is the best!"
     }
     .subscribe(onNect: { string in
     showAlert(text: string)
     })
     }
     */
    
    /*
     
     
     func toggle() {
     toggleSwitch.rx.isOn
     .subscribe(onNext: { enabled in
     print(enabled ? "it's ON" : "it's OFF")
     })
     }
     */
    func example() {
        let one = 1
        let two = 2
        let three = 3
        let observable: Observable<Int> = Observable<Int>.just(one)
        
        let observable2 = Observable.of(one, two, three) // Observable<Int>
        let observable3 = Observable.of([one, two, three]) // Observable<[Int]>
        let observable4 = Observable.from([one, two, three]) // Observable<Int>
        
        //The from operator creates an observable of individual type instances from a regular array of elements. it is an Observable of Int, not [Int]. The from operator only takes an array.
        
        //        That’s because the of operator takes a variadic parameter of the type inferred by the elements passed to it.
    }
    
    func calendarDayChanged() {
        let observer = NotificationCenter.default.addObserver(
            forName: .NSCalendarDayChanged,
            object: nil,
            queue: nil
        ) { notification in
            // Handle receiving notification
        }
    }
    
    //    Subscribing to an RxSwift observable is fairly similar; you call observing an observable subscribing to it. So instead of addObserver(), you use subscribe(). Unlike NotificationCenter, where developers typically use only its .default singleton instance, each observable in Rx is different.
    
    //    More importantly, an observable won’t send events until it has a subscriber. Remember that an observable is really a sequence definition; subscribing to an observable is really more like calling next() on an Iterator in the Swift standard library:
    
    func dummy() {
        let sequence = 0..<3
        
        var iterator = sequence.makeIterator()
        
        while let n = iterator.next() {
            print(n)
        }
    }
    
    func example2() {
        let one = 1
        let two = 2
        let three = 3
        
        let observable = Observable.of(one, two, three)
        
        //Subscribes an event handler to an observable sequence.
        //        observable.subscribe { event in
        //            print(event)
        //        }
        
        /*
         next(1) 123
         next(2) 123
         next(3) 123
         completed 123
         */
        
        //        observable.subscribe { event in
        //            if let element = event.element {
        //                print(element)
        //            }
        //        }
        /*
         1
         2
         3
         */
        // simple form of code above
        observable.subscribe(onNext: { element in
            print(element)
        })
        /*
         You’ve seen how to create observable of one element and of many elements. But what about an observable of zero elements? The empty operator creates an empty observable sequence with zero elements; it will only emit a .completed event.
         */
        
        
    }
    
    func example3() {
        let observable = Observable<Void>.empty()
        
        observable.subscribe { element in
            print(element)
        } onCompleted: {
            // A .completed event does not include an element, so simply print a message.
            print("completed")
        }
    }
    // completed
    
    func example4() {
        let observable = Observable<Any>.never()
        
        observable
            .subscribe(
                onNext: { element in
                    print(element)
                },
                onCompleted: {
                    print("Completed")
                }
            )
    }
    // As opposed to the empty operator, the never operator creates an observable that doesn’t emit anything and never terminates. It can be use to represent an infinite duration. Add this example to the playground
    
    func rangeExample() {
        let observable = Observable<Int>.range(start: 1, count: 10)
        
        observable.subscribe(onNext: { i in
            
            let n = Double(i)
            let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
                                    2.23606).rounded())
            print("fibonacci : \(fibonacci)")
        })
    }
    //1. Create an observable using the range operator, which takes a start integer value and a count of sequential integers to generate.
    //2. Calculate and print the nth Fibonacci number for each emitted element.
    
    
    /*
     fibonacci : 0
     fibonacci : 1
     fibonacci : 2
     fibonacci : 3
     fibonacci : 5
     fibonacci : 8
     fibonacci : 13
     fibonacci : 21
     fibonacci : 34
     fibonacci : 55
     */
    
    
    // Disposing and terminating .
    
    func disposingAndTerminating() {
        let observable = Observable.of("A", "B", "C")
        let subscription = observable.subscribe{ event in
            print(event)
        }
    }
    /*
     next(A)
     next(B)
     next(C)
     completed
     */
    
    // Remember that an observable doesn't do anything until it receives a subscription.
    // It's the subscription that triggers an observable to begin emitting events, up until it emits an .error or .completed event and is terminated.
    // You can manually cause an observable to terminate by cancelling a subscription to it.
    
    // 1. Create an observable of some strings.
    // 2. Subscribe to the observable, this time saving the returned Disposable as a local constant called subscription.
    // 3. print each emitted event in the handler
    
    
    
    // To explicitly cancel a subscription, call dispose() on it. After you cancel the subscription, or dispose of it, the observable in the current example will stop emitting events.
    func disposeBag() {
        let disposeBag = DisposeBag()
        
        Observable.of("A", "B", "C")
            .subscribe {
                print($0)
            }
            .addDisposableTo(disposeBag)
    }
    // 1. Create a dispose bag.
    // 2. Create an observable.
    // 3. Subscribe to the observable and print out the emitted event using the default argument name $0 rather than explicitly defining an argument name.
    // 4. Add the return value from subscribe to the disposeBag.
    
    // This is the pattern you'll use the most frequently.
    // creating and subscribing to an observable and immediately adding the subscription to a dispose bag.
    
    //Why bother with disposables at all? If you forget to add a subscription to a dispose bag, or manually call dispose on it when you’re done with the subscription, or in some other way cause the observable to terminate at some point, you will probably leak memory.
    
    
    func createExample() {
//        let disposeBag = DisposeBag()
//
//        Observable<String>.create { observer in
//
//        }
    }
    //In the previous examples, you’ve created observables with specific .next event elements. Another way to specify all events that an observable will emit to subscribers is by using the create operator.
}




