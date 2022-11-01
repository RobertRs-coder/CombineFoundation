/*
  Subscribers.
 */
import Combine

let publisher1 = [1,2,3].publisher

print("-------------------------------")
print("Example 1: Save subscriber")
print("-------------------------------")

let subscriber1 = publisher1.sink { data in
    print("Example 1: \(data)")
}
//subscriber1.cancel() //Cancel the subscriber


print("-------------------------------")
print("Example 2: Save subscriber with AnyCancellable")
print("-------------------------------")

let subscriber2: AnyCancellable?

subscriber2 = publisher1.sink { data in
    print("Example 2: \(data)")
}


print("-------------------------------")
print("Example 3: Store -> Most used")
print("-------------------------------")

var subscriber3 = Set<AnyCancellable>()

publisher1.sink { data in
    print("Example 3: \(data)")
}
.store(in: &subscriber3)



print("-------------------------------")
print("Example 4: Direct Assign")
print("-------------------------------")

class DataObject{
    var value : Int = 0{
        //Property Observer
        didSet{
            //When attribute changes its value do:
            print("Ejerc4. Valor asignado \(value)")
        }
    }
}

let dataObj = DataObject() //Instantiate the last class

var subscriber4 = Set<AnyCancellable>()

publisher1
    .assign(to: \.value , on: dataObj)
    .store(in: &subscriber4)


print("-------------------------------")
print("Example 5: ViewModel Example")
print("-------------------------------")

final class ViewModel{
    var value:String = ""{
        didSet{
            //When attribute changes its value do:
            print("Example 5: assigned value: \(value)")
        }
    }
    
    var subscriber = Set<AnyCancellable>()
    var publisher = ["Hi", "Keepcoders"].publisher
    
    init(){
        publisher
            .assign(to: \.value, on: self)//It is the class itself
            .store(in: &subscriber)
    }
}

let viewModel = ViewModel()
