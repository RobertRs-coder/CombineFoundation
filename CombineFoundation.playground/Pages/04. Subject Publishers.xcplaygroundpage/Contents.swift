/*
    Create Subject Publishers
 */

import Combine

// Example 1. Subject Publisher for current value

// - Step 1.  Create personalize Publisher
let subject = CurrentValueSubject<Int, Never>(0) //Default value is 0

subject.value
subject.send(1) //We send 1 by the publisher
subject.value

//Create subscriber from the publisher
let suscriber = subject.sink { completion in
    switch completion{
    case .failure(let error):
        print("Example 1: Error -> \(error)")
    case .finished:
        print("Example 2: Finished")
    }
} receiveValue: { data in
    print("Example 1: receive the value -> \(data)")
}


//Send by the publisher
subject.send(11)
subject.send(completion: .finished)
subject.send(22) //Never arrive to the subscriber



// Example 2. PassThourghSubject with Never

let publisher2 = PassthroughSubject<Int, Never>() //Without default value

let subscriber1 = publisher2.sink { data in
    print("Example 2:subs1 receive -> \(data)")
}

let subcriber2 = publisher2.sink { data in
    print("Example2: subs2 receive -> \(data)")
}

publisher2.send(1)
publisher2.send(2)
publisher2.send(3)

// Example 3. PassThourghSubject with personalize error

enum myError: Error{
    case networkError
    case otherError
    var errorDescription:String?{
        switch (self){
        case .networkError:
                return "Network Errror"
        case .otherError:
                return "Other Error"
        }
    }
}

//publicado entero y mi error
let publisher3 = PassthroughSubject<Int,myError>()

let sus2 = publisher3.sink { completion in
    switch completion{
    case .finished:
        print("Example 3; finish OK")
    case .failure( let error):
        print("Example 3: Error -> \(error)")
    }
} receiveValue: { dato in
    print("Example 3: Receive \(dato)")
}

publisher3.send(10)
publisher3.send(20)
publisher3.send(30)
//publisher3.send(completion: .finished)
publisher3.send(completion: .failure(.networkError))




// Ejemplo 4:  Merge & Zip
var subscriber4 = Set<AnyCancellable>()

let publisher41 = PassthroughSubject<Int, Never>()
let publisher42 = PassthroughSubject<String, Never>()
let publisher43 = PassthroughSubject<Int, Never>()

publisher41
    .zip(publisher43) //Until publisher 43 send data the subcriber doesn't receive nothing
    .sink { data in
        print(" Example 4. Receive -> \(data)")
    }
    .store(in: &subscriber4)

publisher41.send(1)
publisher43.send(2)
