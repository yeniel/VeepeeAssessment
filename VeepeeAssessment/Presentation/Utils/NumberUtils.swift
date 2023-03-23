//
//  Utils.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

extension Double {
    var temperatureFormat: String {
        let temperatureInCelcius = Measurement(value: self, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()

        formatter.numberFormatter.maximumFractionDigits = 0

        return formatter.string(from: temperatureInCelcius)
    }

    var windFormat: String {
        let windInKmh = Measurement(value: self, unit: UnitSpeed.kilometersPerHour)
        let formatter = MeasurementFormatter()

        formatter.numberFormatter.maximumFractionDigits = 0

        return formatter.string(from: windInKmh)
    }

    var percentageFormat: String {
        String(self) + "%"
    }
}

extension Int {
    var pressureFormat: String {
        let pressureInHPA = Measurement(value: Double(self), unit: UnitPressure.hectopascals)

        return MeasurementFormatter().string(from: pressureInHPA)
    }

    var percentageFormat: String {
        String(self) + "%"
    }

    var visibilityFormat: String {
        let visibilityInKm = Measurement(value: Double(self / 1000), unit: UnitLength.kilometers)
        let formatter = MeasurementFormatter()

        formatter.numberFormatter.maximumFractionDigits = 0

        return formatter.string(from: visibilityInKm)
    }
}
