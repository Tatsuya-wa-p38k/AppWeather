
import UIKit

class TableListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    let weatherList = WeatherList()
    //struct.swiftから引っぱってkた
    var areas: [AreaWeather] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        fetchAreaData()

        // UIRefreshControlの設定
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    //上から下に引っ張った時に画面が更新される2/2
    @objc private func onRefresh(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()

            //最新の時間の天気に更新するため下記関数を再度画面を引っ張った際にやらせる
            self?.fetchAreaData()
        }
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
           let destinationVC = segue.destination as? ViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            //areasの情報をViewControllerの変数acceptAreaWeatherに渡すためのコード
            destinationVC.acceptAreaWeather = areas[indexPath.row]

            // ViewController に TableListViewController の参照を渡す
            destinationVC.tableListViewController = self
        }
    }

    // セルの選択を解除するメソッド
    func deselectSelectedRow() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}
