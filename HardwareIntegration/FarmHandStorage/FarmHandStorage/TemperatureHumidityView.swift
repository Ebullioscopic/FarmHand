//
//  TemperatureHumidityView.swift
//  FarmHandStorage
//
//  Created by admin63 on 17/09/24.
//

import SwiftUI

struct TemperatureHumidityView: View {
    @State private var temperature: Double = 0
    @State private var humidity: Double = 0
    @State private var isLoading: Bool = true

    let maxTemperature: Double = 50
    let maxHumidity: Double = 100
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()
                CircularProgressView(value: temperature, maxValue: maxTemperature, color: .red, label: "Temperature", unit: "°C")
                Spacer()
            }
            .padding()

            HStack {
                Spacer()
                CircularProgressView(value: humidity, maxValue: maxHumidity, color: .blue, label: "Humidity", unit: "%")
                Spacer()
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .onAppear {
            startFetchingData()
        }
        .onDisappear {
            stopFetchingData()
        }
        .onReceive(timer) { _ in
            fetchData()
        }
    }

    func fetchData() {
        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    if let decodedData = try? JSONDecoder().decode(SensorData.self, from: data) {
                        self.temperature = decodedData.temperature
                        self.humidity = decodedData.humidity
                    } else {
                        print("Failed to decode data")
                    }
                } else {
                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }.resume()
    }

    func startFetchingData() {
        fetchData()
    }

    func stopFetchingData() {
        timer.upstream.connect().cancel()
    }
}

struct CircularProgressView: View {
    var value: Double
    var maxValue: Double
    var color: Color
    var label: String
    var unit: String

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(color)

                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.value / self.maxValue, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270.0))

                VStack {
                    Text(String(format: "%.1f", value))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(color)
                    Text(unit)
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 200, height: 200)

            Text(label)
                .font(.title2)
                .bold()
                .foregroundColor(color)
        }
    }
}
