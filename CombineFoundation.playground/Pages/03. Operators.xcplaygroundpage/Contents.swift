/*
    Operators. Transform the signal from the publisher
 */
import Combine

print("-------------------------------")
print("Example 1: Transformation")
print("-------------------------------")

let publisher1 = [1,2,3].publisher
let subscriber1 = publisher1
//    .map{ data in
//        //Transform number to string
//        "\(data) €"
    .map{ //Compact way
        "\($0) €"
    }
    .replaceNil(with: ":-)") //In case of nil value replace it
    .sink { string in
        //Unwrap optional
        if let string = string {
            print("Receive: \(string)")
        }
    }

print("-------------------------------")
print("Example 2: Filters")
print("-------------------------------")
let nums = [1,1,2,2,4,5,6,7,8,9].publisher

//Multiple of 3
nums
    .filter{ $0.isMultiple(of: 3)}
    .sink {
        print("Multiple of 3 -> \($0)")
    }

//Delete duplicates
nums
    .removeDuplicates()
    .sink {
        print("Duplicates -> \($0)")
    }

//Filtro: Zero remainder
nums
    .first{$0 % 3 == 0}
    .sink {
        print("First value with zero remainder -> \($0)")
    }

// --- Secuence Operators
let publisher = [1,2,3,4,5,6,7,8,9].publisher

publisher
    .min()
    .sink { value in
        print("minimum: \(value)")
    }

publisher
    .max()
    .sink { value in
        print("maximum: \(value)")
    }

publisher
    .output(at: 2)
    .sink { value in
        print("index 2: \(value)")
    }

// --- Debug Operators
publisher
    .breakpoint(receiveOutput: {$0 == 2}) //Breakpoint on this value
    .print("Debug") //Print all information of the publisher
    .sink { data in
        //print("Debug: receive \(data)")
    }
