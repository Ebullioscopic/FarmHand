//
//  ContentView.swift
//  FarmHandStorage
//
//  Created by admin63 on 16/09/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
//import SwiftUI
//
//struct ContentView: View {
//    @State private var temperature: String = "Loading..."
//    @State private var humidity: String = "Loading..."
//    @State private var tempValue: Double = 0.0
//    @State private var humValue: Double = 0.0
//    @State private var errorMessage: String?
//
//    var body: some View {
//        VStack {
//            if let errorMessage = errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//                    .font(.headline)
//            } else {
//                VStack {
//                    Text("Temperature")
//                        .font(.title)
//                        .padding(.bottom, 5)
//                    
//                    ZStack {
//                        Circle()
//                            .stroke(lineWidth: 20)
//                            .opacity(0.3)
//                            .foregroundColor(.blue)
//                        
//                        Circle()
//                            .trim(from: 0.0, to: min(tempValue / 50, 1.0))
//                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                            .foregroundColor(tempValue > 30 ? .red : .blue)
//                            .rotationEffect(Angle(degrees: 270))
//                            .animation(.easeInOut(duration: 1.0), value: tempValue)
//                        
//                        Text("\(temperature)°C")
//                            .font(.largeTitle)
//                            .bold()
//                    }
//                    .frame(width: 200, height: 200)
//                    .padding(.bottom, 50)
//
//                    Text("Humidity")
//                        .font(.title)
//                        .padding(.bottom, 5)
//                    
//                    ZStack {
//                        Circle()
//                            .stroke(lineWidth: 20)
//                            .opacity(0.3)
//                            .foregroundColor(.green)
//                        
//                        Circle()
//                            .trim(from: 0.0, to: min(humValue / 100, 1.0))
//                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                            .foregroundColor(.green)
//                            .rotationEffect(Angle(degrees: 270))
//                            .animation(.easeInOut(duration: 1.0), value: humValue)
//                        
//                        Text("\(humidity)%")
//                            .font(.largeTitle)
//                            .bold()
//                    }
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
//        .onAppear {
//            fetchData()
//        }
//        .padding()
//    }
//
//    func fetchData() {
//        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
//            self.errorMessage = "Invalid URL"
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    self.errorMessage = error.localizedDescription
//                }
//                return
//            }
//
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    self.errorMessage = "No data received"
//                }
//                return
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    DispatchQueue.main.async {
//                        if let temp = json["temperature"] as? Double, let hum = json["humidity"] as? Double {
//                            self.temperature = String(format: "%.1f", temp)
//                            self.humidity = String(format: "%.1f", hum)
//                            self.tempValue = temp
//                            self.humValue = hum
//                        } else if let error = json["error"] as? String {
//                            self.errorMessage = error
//                        }
//                    }
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.errorMessage = "Failed to parse data"
//                }
//            }
//        }
//        task.resume()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//import SwiftUI
//
//struct ContentView: View {
//    @State private var temperature: String = "--"
//    @State private var humidity: String = "--"
//    @State private var isLoading: Bool = false
//
//    var body: some View {
//        VStack {
//            // Temperature and Humidity Section
//            VStack {
//                // Temperature Icon and Value
//                HStack {
//                    Image(systemName: "thermometer")
//                        .font(.system(size: 50))
//                        .foregroundColor(.red)
//                    Text("\(temperature) °C")
//                        .font(.largeTitle)
//                        .bold()
//                }
//                .padding()
//
//                // Humidity Icon and Value
//                HStack {
//                    Image(systemName: "humidity.fill")
//                        .font(.system(size: 50))
//                        .foregroundColor(.blue)
//                    Text("\(humidity) %")
//                        .font(.largeTitle)
//                        .bold()
//                }
//                .padding()
//            }
//            .padding()
//            .background(Color(.systemGray6))
//            .cornerRadius(15)
//            .shadow(radius: 10)
//
//            Spacer()
//
//            // Fetch Button
//            Button(action: {
//                // Fetch the data from the Raspberry Pi API
//                fetchData()
//            }) {
//                HStack {
//                    if isLoading {
//                        ProgressView() // Display a loading spinner when fetching
//                    } else {
//                        Image(systemName: "arrow.clockwise.circle.fill")
//                            .font(.system(size: 40))
//                        Text("Fetch Data")
//                            .font(.title2)
//                            .bold()
//                    }
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(15)
//                .shadow(radius: 5)
//            }
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground))
//        .edgesIgnoringSafeArea(.all)
//    }
//
//    // Function to fetch data from Django API
//    func fetchData() {
//        self.isLoading = true
//        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
//            print("Invalid URL")
//            self.isLoading = false
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                self.isLoading = false // Stop showing the spinner after response
//
//                if let data = data {
//                    if let decodedData = try? JSONDecoder().decode(SensorData.self, from: data) {
//                        self.temperature = String(format: "%.1f", decodedData.temperature)
//                        self.humidity = String(format: "%.1f", decodedData.humidity)
//                    } else {
//                        print("Failed to decode data")
//                    }
//                } else {
//                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
//                }
//            }
//        }.resume()
//    }
//}
//
//// Data structure to hold the sensor data (matches Django API response)
//struct SensorData: Codable {
//    var temperature: Double
//    var humidity: Double
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//import SwiftUI
//
//struct ContentView: View {
//    @State private var temperature: Double = 0
//    @State private var humidity: Double = 0
//    @State private var isLoading: Bool = true
//
//    let maxTemperature: Double = 50  // Maximum temperature value for the progress circle
//    let maxHumidity: Double = 100    // Maximum humidity value for the progress circle
//    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect() // Fetch data every 5 seconds
//
//    var body: some View {
//        VStack {
//            // Temperature Section with Circular Progress Bar
//            CircularProgressView(value: temperature, maxValue: maxTemperature, color: .red, label: "Temperature", unit: "°C")
//                .padding()
//
//            // Humidity Section with Circular Progress Bar
//            CircularProgressView(value: humidity, maxValue: maxHumidity, color: .blue, label: "Humidity", unit: "%")
//                .padding()
//
//            Spacer()
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground))
//        .onAppear {
//            fetchData() // Fetch data when the view appears
//        }
//        .onReceive(timer) { _ in
//            fetchData() // Fetch data automatically on timer
//        }
//    }
//
//    // Function to fetch data from Django API
//    func fetchData() {
//        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    if let decodedData = try? JSONDecoder().decode(SensorData.self, from: data) {
//                        self.temperature = decodedData.temperature
//                        self.humidity = decodedData.humidity
//                    } else {
//                        print("Failed to decode data")
//                    }
//                } else {
//                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
//                }
//            }
//        }.resume()
//    }
//}
//
//// Data structure to hold the sensor data (matches Django API response)
//struct SensorData: Codable {
//    var temperature: Double
//    var humidity: Double
//}
//
//struct CircularProgressView: View {
//    var value: Double
//    var maxValue: Double
//    var color: Color
//    var label: String
//    var unit: String
//
//    var body: some View {
//        VStack {
//            ZStack {
//                // Background Circle
//                Circle()
//                    .stroke(lineWidth: 20)
//                    .opacity(0.3)
//                    .foregroundColor(color)
//
//                // Foreground Circle representing the progress
//                Circle()
//                    .trim(from: 0.0, to: CGFloat(min(self.value / self.maxValue, 1.0)))
//                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(color)
//                    .rotationEffect(Angle(degrees: 270.0))  // Start the progress from top
//
//                // Value Display in the middle of the circle
//                VStack {
//                    Text(String(format: "%.1f", value))
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(color)
//                    Text(unit)
//                        .font(.title2)
//                        .foregroundColor(.gray)
//                }
//            }
//            .frame(width: 200, height: 200)
//
//            // Label below the circular progress bar
//            Text(label)
//                .font(.title2)
//                .bold()
//                .foregroundColor(color)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//import SwiftUI
//
//struct ContentView: View {
//    @State private var temperature: Double = 0
//    @State private var humidity: Double = 0
//    @State private var isLoading: Bool = true
//
//    let maxTemperature: Double = 50  // Maximum temperature value for the progress circle
//    let maxHumidity: Double = 100    // Maximum humidity value for the progress circle
//    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect() // Fetch data every 5 seconds
//
//    var body: some View {
//        VStack {
//            Spacer() // Add space at the top
//            
//            // Temperature Section with Circular Progress Bar
//            HStack {
//                Spacer()
//                CircularProgressView(value: temperature, maxValue: maxTemperature, color: .red, label: "Temperature", unit: "°C")
//                Spacer()
//            }
//            .padding()
//
//            // Humidity Section with Circular Progress Bar
//            HStack {
//                Spacer()
//                CircularProgressView(value: humidity, maxValue: maxHumidity, color: .blue, label: "Humidity", unit: "%")
//                Spacer()
//            }
//            .padding()
//
//            Spacer() // Add space at the bottom
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground))
//        .onAppear {
//            fetchData() // Fetch data when the view appears
//        }
//        .onReceive(timer) { _ in
//            fetchData() // Fetch data automatically on timer
//        }
//    }
//
//    // Function to fetch data from Django API
//    func fetchData() {
//        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    if let decodedData = try? JSONDecoder().decode(SensorData.self, from: data) {
//                        self.temperature = decodedData.temperature
//                        self.humidity = decodedData.humidity
//                    } else {
//                        print("Failed to decode data")
//                    }
//                } else {
//                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
//                }
//            }
//        }.resume()
//    }
//}
//
//// Data structure to hold the sensor data (matches Django API response)
//struct SensorData: Codable {
//    var temperature: Double
//    var humidity: Double
//}
//
//struct CircularProgressView: View {
//    var value: Double
//    var maxValue: Double
//    var color: Color
//    var label: String
//    var unit: String
//
//    var body: some View {
//        VStack {
//            ZStack {
//                // Background Circle
//                Circle()
//                    .stroke(lineWidth: 20)
//                    .opacity(0.3)
//                    .foregroundColor(color)
//
//                // Foreground Circle representing the progress
//                Circle()
//                    .trim(from: 0.0, to: CGFloat(min(self.value / self.maxValue, 1.0)))
//                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(color)
//                    .rotationEffect(Angle(degrees: 270.0))  // Start the progress from top
//
//                // Value Display in the middle of the circle
//                VStack {
//                    Text(String(format: "%.1f", value))
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(color)
//                    Text(unit)
//                        .font(.title2)
//                        .foregroundColor(.gray)
//                }
//            }
//            .frame(width: 200, height: 200)
//
//            // Label below the circular progress bar
//            Text(label)
//                .font(.title2)
//                .bold()
//                .foregroundColor(color)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//////////////////////////////////////////////////
//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//    var body: some View {
//        TabView {
//            // First Tab: Temperature and Humidity View
//            TemperatureHumidityView()
//                .tabItem {
//                    Label("Sensor Data", systemImage: "thermometer")
//                }
//            
//            // Second Tab: Image Upload and Inference
//            ImageUploadView()
//                .tabItem {
//                    Label("Image Analysis", systemImage: "camera")
//                }
//        }
//    }
//}
//
//// MARK: - Temperature and Humidity View
//struct TemperatureHumidityView: View {
//    @State private var temperature: Double = 0
//    @State private var humidity: Double = 0
//    @State private var isLoading: Bool = true
//
//    let maxTemperature: Double = 50  // Maximum temperature value for the progress circle
//    let maxHumidity: Double = 100    // Maximum humidity value for the progress circle
//    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect() // Fetch data every 5 seconds
//
//    var body: some View {
//        VStack {
//            Spacer() // Add space at the top
//            
//            // Temperature Section with Circular Progress Bar
//            HStack {
//                Spacer()
//                CircularProgressView(value: temperature, maxValue: maxTemperature, color: .red, label: "Temperature", unit: "°C")
//                Spacer()
//            }
//            .padding()
//
//            // Humidity Section with Circular Progress Bar
//            HStack {
//                Spacer()
//                CircularProgressView(value: humidity, maxValue: maxHumidity, color: .blue, label: "Humidity", unit: "%")
//                Spacer()
//            }
//            .padding()
//
//            Spacer() // Add space at the bottom
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground))
//        .onAppear {
//            fetchData() // Fetch data when the view appears
//        }
//        .onReceive(timer) { _ in
//            fetchData() // Fetch data automatically on timer
//        }
//    }
//
//    // Function to fetch data from Django API
//    func fetchData() {
//        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    if let decodedData = try? JSONDecoder().decode(SensorData.self, from: data) {
//                        self.temperature = decodedData.temperature
//                        self.humidity = decodedData.humidity
//                    } else {
//                        print("Failed to decode data")
//                    }
//                } else {
//                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
//                }
//            }
//        }.resume()
//    }
//}
//
//// Data structure to hold the sensor data (matches Django API response)
//struct SensorData: Codable {
//    var temperature: Double
//    var humidity: Double
//}
//
//struct CircularProgressView: View {
//    var value: Double
//    var maxValue: Double
//    var color: Color
//    var label: String
//    var unit: String
//
//    var body: some View {
//        VStack {
//            ZStack {
//                // Background Circle
//                Circle()
//                    .stroke(lineWidth: 20)
//                    .opacity(0.3)
//                    .foregroundColor(color)
//
//                // Foreground Circle representing the progress
//                Circle()
//                    .trim(from: 0.0, to: CGFloat(min(self.value / self.maxValue, 1.0)))
//                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(color)
//                    .rotationEffect(Angle(degrees: 270.0))  // Start the progress from top
//
//                // Value Display in the middle of the circle
//                VStack {
//                    Text(String(format: "%.1f", value))
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(color)
//                    Text(unit)
//                        .font(.title2)
//                        .foregroundColor(.gray)
//                }
//            }
//            .frame(width: 200, height: 200)
//
//            // Label below the circular progress bar
//            Text(label)
//                .font(.title2)
//                .bold()
//                .foregroundColor(color)
//        }
//    }
//}
//
//// MARK: - Image Upload and Inference View
//struct ImageUploadView: View {
//    @State private var image: UIImage?
//    @State private var inferenceResult: InferenceResult?
//    @State private var isShowingImagePicker = false
//    @State private var isLoading = false
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//                    .cornerRadius(10)
//            } else {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 300, height: 300)
//                    .cornerRadius(10)
//                    .overlay(Text("Tap to upload image"))
//                    .onTapGesture {
//                        isShowingImagePicker = true
//                    }
//            }
//            
//            if let result = inferenceResult {
//                // Display the results
//                Text("Type: \(result.image_type)")
//                Text("Name: \(result.image_name)")
//                Text("Freshness: \(result.freshness)")
//                Text("Shelf Life: \(result.shelf_life) \(result.shelf_life_unit)")
//                Text("Description: \(result.description)")
//            }
//
//            if isLoading {
//                ProgressView("Processing image...")
//                    .padding()
//            }
//
//            Button(action: uploadImage) {
//                HStack {
//                    Image(systemName: "arrow.up.circle")
//                    Text("Upload and Analyze")
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            .padding()
//        }
//        .sheet(isPresented: $isShowingImagePicker) {
//            ImagePicker(image: $image)
//        }
//    }
//
//    // Upload image and process inference
//    func uploadImage() {
//        guard let image = image else {
//            return
//        }
//
//        isLoading = true
//
//        let url = URL(string: "http://raspberrypi5.local:8000/image/")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let boundary = UUID().uuidString
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var data = Data()
//        data.append("--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//        data.append(image.jpegData(compressionQuality: 0.8)!)
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//        URLSession.shared.uploadTask(with: request, from: data) { responseData, _, _ in
//            if let responseData = responseData {
//                if let decodedResult = try? JSONDecoder().decode(InferenceResult.self, from: responseData) {
//                    DispatchQueue.main.async {
//                        print(decodedResult)
//                        self.inferenceResult = decodedResult
//                        self.isLoading = false
//                    }
//                }
//            }
//        }.resume()
//    }
//}
//
//// Data structure for inference result (matches JSON response schema)
//struct InferenceResult: Codable {
//    var image_type: String
//    var image_name: String
//    var freshness: Int
//    var shelf_life: String
//    var shelf_life_unit: String
//    var description: String
//}
//
//// Image Picker to pick an image from the gallery or camera
//struct ImagePicker: UIViewControllerRepresentable {
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var image: UIImage?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .camera  // Use `.photoLibrary` if you want to open the photo library instead
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
///////////LOLOLOLOLOLOLOLADSFJKQWLNRLKFNASDFKJNDS:AKJFWDF
///<<<<<<<<Working>>>>>>>
//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//    var body: some View {
//        TabView {
//            // First Tab: Temperature and Humidity View
//            TemperatureHumidityView()
//                .tabItem {
//                    Label("Sensor Data", systemImage: "thermometer")
//                }
//            
//            // Second Tab: Image Upload and Inference
//            ImageUploadView()
//                .tabItem {
//                    Label("Image Analysis", systemImage: "camera")
//                }
//        }
//    }
//}
//
//// MARK: - Temperature and Humidity View
//struct TemperatureHumidityView: View {
//    @State private var temperature: Double = 0
//    @State private var humidity: Double = 0
//    @State private var isLoading: Bool = false
//    
//    let maxTemperature: Double = 50  // Maximum temperature value for the progress circle
//    let maxHumidity: Double = 100    // Maximum humidity value for the progress circle
//    @State private var timer: Timer?
//
//    var body: some View {
//        VStack {
//            Spacer()
//            
//            HStack {
//                Spacer()
//                CircularProgressView(value: temperature, maxValue: maxTemperature, color: .red, label: "Temperature", unit: "°C")
//                Spacer()
//            }
//            .padding()
//
//            HStack {
//                Spacer()
//                CircularProgressView(value: humidity, maxValue: maxHumidity, color: .blue, label: "Humidity", unit: "%")
//                Spacer()
//            }
//            .padding()
//
//            Spacer()
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground))
//        .onAppear {
//            startFetchingData()
//        }
//        .onDisappear {
//            stopFetchingData()
//        }
//    }
//
//    // Start fetching data with a timer
//    func startFetchingData() {
//        isLoading = true
//        fetchData() // Fetch initial data
//        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
//            fetchData()
//        }
//    }
//
//    // Stop fetching data by invalidating the timer
//    func stopFetchingData() {
//        timer?.invalidate()
//        timer = nil
//        isLoading = false
//    }
//
//    // Function to fetch data from Django API
//    func fetchData() {
//        guard let url = URL(string: "http://raspberrypi5.local:8000/data/") else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    if let decodedData = try? JSONDecoder().decode(SensorData.self, from: data) {
//                        self.temperature = decodedData.temperature
//                        self.humidity = decodedData.humidity
//                    } else {
//                        print("Failed to decode data")
//                    }
//                } else {
//                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
//                }
//                self.isLoading = false
//            }
//        }.resume()
//    }
//}
//
//// Data structure to hold the sensor data (matches Django API response)
//struct SensorData: Codable {
//    var temperature: Double
//    var humidity: Double
//}
//
//struct CircularProgressView: View {
//    var value: Double
//    var maxValue: Double
//    var color: Color
//    var label: String
//    var unit: String
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Circle()
//                    .stroke(lineWidth: 20)
//                    .opacity(0.3)
//                    .foregroundColor(color)
//
//                Circle()
//                    .trim(from: 0.0, to: CGFloat(min(self.value / self.maxValue, 1.0)))
//                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(color)
//                    .rotationEffect(Angle(degrees: 270.0))
//
//                VStack {
//                    Text(String(format: "%.1f", value))
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(color)
//                    Text(unit)
//                        .font(.title2)
//                        .foregroundColor(.gray)
//                }
//            }
//            .frame(width: 200, height: 200)
//
//            Text(label)
//                .font(.title2)
//                .bold()
//                .foregroundColor(color)
//        }
//    }
//}
//
//// MARK: - Image Upload and Inference View
//struct ImageUploadView: View {
//    @State private var image: UIImage?
//    @State private var inferenceResult: InferenceResult?
//    @State private var isShowingImagePicker = false
//    @State private var isLoading = false
//    @State private var errorMessage: String?
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//                    .cornerRadius(10)
//            } else {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 300, height: 300)
//                    .cornerRadius(10)
//                    .overlay(Text("Tap to upload image"))
//                    .onTapGesture {
//                        isShowingImagePicker = true
//                    }
//            }
//            
//            if let result = inferenceResult {
//                VStack(alignment: .leading) {
//                    Text("Type: \(result.image_type)")
//                    Text("Name: \(result.image_name)")
//                    Text("Freshness: \(result.freshness)")
//                    Text("Shelf Life: \(result.shelf_life) \(result.shelf_life_unit)")
//                    Text("Description: \(result.description)")
//                }
//                .padding()
//            }
//
//            if isLoading {
//                ProgressView("Processing image...")
//                    .padding()
//            }
//
//            if let errorMessage = errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            Button(action: uploadImage) {
//                HStack {
//                    Image(systemName: "arrow.up.circle")
//                    Text("Upload and Analyze")
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            .padding()
//        }
//        .sheet(isPresented: $isShowingImagePicker) {
//            ImagePicker(image: $image)
//        }
//    }
//
//    func uploadImage() {
//        guard let image = image else {
//            return
//        }
//
//        isLoading = true
//        errorMessage = nil
//
//        let url = URL(string: "http://raspberrypi5.local:8000/image/")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let boundary = UUID().uuidString
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var data = Data()
//        data.append("--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//        data.append(image.jpegData(compressionQuality: 0.8)!)
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//        URLSession.shared.uploadTask(with: request, from: data) { responseData, response, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.errorMessage = "Upload failed: \(error.localizedDescription)"
//                    self.isLoading = false
//                    return
//                }
//
//                guard let responseData = responseData else {
//                    self.errorMessage = "No response data"
//                    self.isLoading = false
//                    return
//                }
//
//                if let decodedResult = try? JSONDecoder().decode(InferenceResult.self, from: responseData) {
//                    self.inferenceResult = decodedResult
//                } else {
//                    self.errorMessage = "Failed to decode response data"
//                }
//
//                self.isLoading = false
//            }
//        }.resume()
//    }
//}
//
//struct InferenceResult: Codable {
//    var image_type: String
//    var image_name: String
//    var freshness: String
//    var shelf_life: String
//    var shelf_life_unit: String
//    var description: String
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var image: UIImage?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .camera
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
///<<<Working>>>>
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: TemperatureHumidityView()) {
                    HStack {
                        Image(systemName: "thermometer")
                        Text("Sensor Data")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: ImageUploadView()) {
                    HStack {
                        Image(systemName: "camera")
                        Text("Image Analysis")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Home")
            .background(Color(.systemGroupedBackground))
        }
    }
}
