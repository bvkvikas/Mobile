
import Foundation

// MARK: - Train
class Train: Decodable {
    let data: [Datum]
}

class Datum: Decodable {
    let attributes: Attributes
    let id: String
    let type: String
}

class Attributes: Decodable {
    let color, description: String
    let direction_destinations, direction_names: [String]

}
