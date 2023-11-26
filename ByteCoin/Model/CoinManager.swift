import Foundation

protocol CoinDelegate{
    func didUpdate(coin: ModelCoin)
    func didFail(error: Error)
}
struct CoinManager {
    var delegate: CoinDelegate?
    let currencyArray = ["BTC", "ETH","SOL","AVAX","XRP","ADA","DOGE","TRX","LINK","LTC","XLM","MINA"]
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "?apikey=D6E6884A-C908-4AF1-BA90-669F93610C51"
    func getUrl(cryptoName: String){
        let urlString = "\(baseURL)\(cryptoName)/USDT/\(apiKey)"
        performRequest(urlString)
    }
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFail(error: error!)
                }else{
                    if let data = data{
                        if let model = parseJSON(data: data){
                            self.delegate?.didUpdate(coin: model)
            
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(data: Data) ->  ModelCoin?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ModelCoin.self, from: data)
            let price = decodedData.rate
            let modelCoin = ModelCoin(rate: price)
            return modelCoin
        }catch{
            return nil
        }
    }
}
