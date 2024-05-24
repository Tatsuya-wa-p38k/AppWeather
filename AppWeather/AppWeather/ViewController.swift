//
//  ViewController.swift
//  AppWeather
//
//  Created by spark-06 on 2024/05/23.
//

import UIKit
//(delegateで処理をWeather.swiftに移動させるため下記コードは不要)
//import YumemiWeather

class ViewController: UIViewController{

    //Weather.swiftにあるクラスWeatherDetailをインスタンス化
    //(最初にやるのでclass ViewController又はアウトレット接続のすぐ下に記載する)
    var weatherDetail = WeatherDetail()


    @IBOutlet weak var weatherType: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンス化したクラスにはデリゲートを持っていく自分自身にお約束
        weatherDetail.delegate = self
        // Do any additional setup after loading the view.

    }


    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func buttonReload(_ sender: Any) {
        //18行目にインスタンス化した「weatherDetail」のメソッド(Weather.swiftにある「setWeatherType()」)を下記に記載をする
        weatherDetail.setWeatherType()
    }
}


extension ViewController: WeatherDelegate {

    func setWeatherType(type:String) {
        var weatherName = "sunny"
        var tintColor = UIColor.red

        switch type {
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
        weatherType.image = UIImage(named: weatherName)
        weatherType.tintColor = tintColor

    }

}


