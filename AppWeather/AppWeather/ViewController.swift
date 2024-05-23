//
//  ViewController.swift
//  AppWeather
//
//  Created by spark-06 on 2024/05/23.
//

import UIKit

//さっきAdd Packagesより導入したものを使えるようにするため
import YumemiWeather


class ViewController: UIViewController {

    @IBOutlet weak var weatherType: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }



    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func buttonReload(_ sender: Any) {
        //関数で処理したいですね
        outputWeatherType()
    }

    //条件の前提となるはれ、あめ、くもりの情報を、まずはここに持っていきたい

    func outputWeatherType() {

        //天気の情報を取得する(printでログに天気情報が出力されていることが確認)
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
        print(fetchWeatherString)

        switch fetchWeatherString {
        case "sunny" :
            weatherType.image = UIImage(named: "sunny")
            weatherType.tintColor = UIColor.red

        case "cloudy" :
            weatherType.image = UIImage(named: "cloudy")
            weatherType.tintColor = UIColor.gray

        case "rainy" :
            weatherType.image = UIImage(named: "rainy")
            weatherType.tintColor = UIColor.blue

        default:
            break

        }

    }

}

