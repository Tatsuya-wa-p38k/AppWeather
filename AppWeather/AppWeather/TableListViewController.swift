
import UIKit

class TableListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let weatherList = WeatherList()
    //struct.swiftから引っぱってkた
    var areas: [AreaWeather] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        fetchAreaData()
    }
    

    func fetchAreaData() {
        weatherList.fetchWeatherList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherList):
                    self.areas = weatherList
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //areasのカウントをとる
        return areas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let areaWeather = areas[indexPath.row]
        let weather = areaWeather.info

        cell.textLabel?.text = areaWeather.area.rawValue
        // 最高気温、最低気温、天気アイコンを表示
        cell.detailTextLabel?.text = "最高気温: \(weather.maxTemperature)℃, 最低気温: \(weather.minTemperature)℃"

        // 天気アイコンの表示
        switch weather.setWeatherType {
        case "sunny":
            cell.imageView?.image = UIImage(named: "sunny.png")
            cell.imageView?.tintColor = UIColor.red
        case "rainy":
            cell.imageView?.image = UIImage(named: "rainy.png")
            cell.imageView?.tintColor = UIColor.blue
        case "cloudy":
            cell.imageView?.image = UIImage(named: "cloudy.png")
            cell.imageView?.tintColor = UIColor.gray
        default:
            cell.imageView?.image = nil
        }
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeatherDetail",
           let destinationVC = segue.destination as? ViewController {
    //        destinationVC.acceptAreaWeather = AreaWeather
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeatherDetail", sender: self)
        }
}
