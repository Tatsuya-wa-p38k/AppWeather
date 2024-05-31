
import UIKit

class ViewController: UIViewController{

    //Weather.swiftにあるクラスWeatherDetailをインスタンス化
    var weatherDetail = WeatherDetail()

    @IBOutlet weak var weatherType: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンス化したクラスにはデリゲートを持っていく自分自身にお約束
        weatherDetail.delegate = self
        // Do any additional setup after loading the view.
        // 2.画面表示時にindicatorをhiddenで非表示にさせる
<<<<<<< HEAD
        indicator.hidesWhenStopped = true

=======
        indicator.isHidden = true
>>>>>>> 08_ThreadBlock
    }

    @IBAction func buttonClose(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func buttonReload(_ sender: Any) {
        //18行目にインスタンス化した「weatherDetail」のメソッド(Weather.swiftにある「setWeatherType()」)を下記に記載をする
        weatherDetail.setWeatherType()
        indicator.startAnimating()
    }

    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

}

extension ViewController: WeatherDelegate {

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


