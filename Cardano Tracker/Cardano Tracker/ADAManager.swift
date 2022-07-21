
import Foundation

protocol ADAManagerDelegate {
    func didUpdatePrice(price: String)
    func didFailWithError(error: Error)
}

struct ADAManager {
    
    var delegate: ADAManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/ADA/USD"
    let apiKey = "AC44F605-F6FB-422B-BD1B-35AA45C1CA8F"

    func getCoinPrice() {
        
        let urlString = "\(baseURL)/?apikey=\(apiKey)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let adaPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.4f", adaPrice)
                        self.delegate?.didUpdatePrice(price: priceString)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ADAData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

