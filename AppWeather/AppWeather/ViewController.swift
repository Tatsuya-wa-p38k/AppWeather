
import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate{

    var weatherDetail = WeatherDetail()


    //型を揃えないとsegueで情報の受け取りができない、空欄でも落ちないように?をつけている
    var acceptAreaWeather:AreaWeather?

    weak var tableListViewController: TableListViewController?

    @IBOutlet weak var weatherType: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        indicator.isHidden = true

        navigationItem.title = acceptAreaWeather?.area.rawValue
        
        // NavigationControllerのデリゲートを設定
             navigationController?.delegate = self


        if let areaWeather = acceptAreaWeather {
            setWeather(weather: areaWeather.info)
        }
    }

    
    // TableListViewControllerに戻る前に選択解除を行うため
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
          if viewController is TableListViewController {
              tableListViewController?.deselectSelectedRow()
          }
      }


    @IBAction func buttonClose(_ sender: Any) {
        // TableListViewControllerの選択解除メソッドを呼び出す
        tableListViewController?.deselectSelectedRow()

        //NavgationViewControllerを追加したせいでdismiss(animated: true)が機能しないので、
        //下記コードで最初の画面に戻るようにする
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func buttonReload(_ sender: Any) {
        loadWeather()
    }

    //buttonReloadの中の処理が多かったため、それを関数一つで処理できるようにしています
    func loadWeather() {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.weatherDetail.setWeatherType { [weak self] result in

                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.setWeather(weather: weather)
                case .failure(let error):
                    self.showAlert(error: error)
                }
            }
        }
    }

    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    //エラー発生時の処理を下記２つの関数として記載する
    func didEncounterError(error: Error) {
        showAlert(error: error)
    }

    func showAlert(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.indicator.stopAnimating()
        }
    }

    func setWeather(weather: Weather) {
        var weatherName = "sunny"
        var tintColor = UIColor.red

        switch weather.setWeatherType {
            
        case "sunny" :
            weatherName = "sunny"
            tintColor = UIColor.red

        case "cloudy" :
            weatherName = "cloudy"
            tintColor = UIColor.gray

        case "rainy" :
            weatherName = "rainy"
            tintColor = UIColor.blue

        default:
            break
        }

        DispatchQueue.main.async {
            self.weatherType.image = UIImage(named: weatherName)
            self.weatherType.tintColor = tintColor
            self.minTemperature.text = String(weather.minTemperature)
            self.maxTemperature.text = String(weather.maxTemperature)
            self.indicator.stopAnimating()
        }
    }
}
