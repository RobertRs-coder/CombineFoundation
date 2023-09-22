/*
    Publishers.
 */
import Combine

print("--------------------------------")
print("Example 1: Integer Array -> Sink")
print("--------------------------------")

let publisher1 = [1,2,3,4].publisher

publisher1.sink { data in
    //We receive the value
    print("Example 1: \(data)")
}

print("--------------------------------------------")
print("Ejer2: Integer Array -> Sink with completion")
print("--------------------------------------------")

publisher1.sink { completion in
    //We receive the status
    switch completion{
    case .failure(let error):
        print("Example 2: Error =\(error)")
    case .finished:
        print("Example 2: Success")
    }
    
} receiveValue: { data in
    //We receive the value
    print("Ejerc2: \(data)")
}

//Dataflow in this case with completion is: completion(ok)-> value -> .finished || completion(not ok) -> .failure
