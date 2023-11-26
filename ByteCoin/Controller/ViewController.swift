import UIKit

class ViewController: UIViewController{
  
    var coinManager = CoinManager()
    @IBOutlet weak var pickerSelected: UIPickerView!
    @IBOutlet weak var labelCoinName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSelected.dataSource = self
        pickerSelected.delegate = self
        coinManager.delegate = self
    }
}
//MARK: - PROTOCOL
extension ViewController: CoinDelegate{
    func didUpdate(coin: ModelCoin) {
        DispatchQueue.main.async {
            self.labelCoinName.text = String(format: "%.3f", coin.rate )
        }
    }
    func didFail(error: Error) {
        print(error)
    }
}
//MARK: - UIPicker
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch coinManager.currencyArray[row] {
        case "BTC":
            coinManager.getUrl(cryptoName: "BTC")
        case "ETH":
            coinManager.getUrl(cryptoName: "ETH")
        case "SOL":
            coinManager.getUrl(cryptoName: "SOL")
        case "AVAX":
            coinManager.getUrl(cryptoName: "AVAX")
        case "XRP":
            coinManager.getUrl(cryptoName: "XRP")
        case "ADA":
            coinManager.getUrl(cryptoName: "ADA")
        case "DOGE":
            coinManager.getUrl(cryptoName: "DOGE")
        case "TRX":
            coinManager.getUrl(cryptoName: "TRX")
        case "LINK":
            coinManager.getUrl(cryptoName: "LINK")
        case "LTC":
            coinManager.getUrl(cryptoName: "LTC")
        case "XLM":
            coinManager.getUrl(cryptoName: "XLM")
        case "MINA":
            coinManager.getUrl(cryptoName: "MINA")
        default:
            break
        }
    }
}



