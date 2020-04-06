


import Foundation

enum TrainError: Error{
    case noDataAvailable
    case cannotProcessData
}

class TrainRequest {
    
    func getTrains(url: String, userCompletionHandler: @escaping ([Datum]?, TrainError?)-> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: url, completionHandler: { data,_, error in
            guard let data = data else { return }
            do{
                let trains = try JSONDecoder().decode(Train.self, from: data);
                
                userCompletionHandler(trains.data, nil)
                
            }catch{
                print(error)
            }
        })
        task.resume()
    }
    
    
}
