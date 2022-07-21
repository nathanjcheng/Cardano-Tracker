
import UIKit

class ADAController: UIViewController {

    @IBOutlet weak var cardanoLabel: UILabel!
    
    var adaManager = ADAManager()
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adaManager.delegate = self
        adaManager.getCoinPrice()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //SCREEN HAS BEEN CLICKED
        print("I have been touched!")
        adaManager.getCoinPrice()
    }
}

//MARK: - ADAManager Delegate

extension ADAController: ADAManagerDelegate {
    
    func didUpdatePrice(price: String) {
        
        DispatchQueue.main.async {
            self.cardanoLabel.text = price
            print(price)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


