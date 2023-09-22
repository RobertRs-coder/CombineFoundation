/*
   URLSEssion: Asyncronous download image
 */

import Combine
import Foundation
import UIKit

//In need it for asyncronous
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//ViewModel
final class PhotoViewModel: ObservableObject{
    @Published var photo : UIImage? {
        didSet{
            //Assign the photo
            print("ViewModel receive photo")
            photo
        }
    }
    //Create subscriber
    var subscriber: AnyCancellable?
    
    init(){
        
    }
    
    func downloadImage(urlString: String) -> Void{
        let url = URL(string: urlString)!
        
        subscriber = URLSession.shared
            .dataTaskPublisher(for: url)
            .map{
                UIImage(data: $0.data)
            }
            .replaceError(with: UIImage(named: "person.fill"))
            .receive(on: DispatchQueue.main) //Go to main thread because we change UI
            .sink{
                //Unwrap photo
                if let photoDownloaded = $0 {
                    self.photo = photoDownloaded
                }
            }
    }

}

let viewModel = PhotoViewModel()
viewModel.downloadImage(urlString: "https://i.blogs.es/f7b0ed/steve-jobs/1366_2000.jpg")
//Few seconds to receive photo because is async
viewModel.photo
