//
//  ImageUploadView.swift
//  FarmHandStorage
//
//  Created by admin63 on 17/09/24.
//

import SwiftUI

struct ImageUploadView: View {
    @State private var image: UIImage?
    @State private var inferenceResult: InferenceResult?
    @State private var isShowingImagePicker = false
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .overlay(Text("Tap to upload image"))
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
            }
            
            if let result = inferenceResult {
                InferenceResultView(result: result)
            }

            if isLoading {
                ProgressView("Processing image...")
                    .padding()
            }

            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: uploadImage) {
                HStack {
                    Image(systemName: "arrow.up.circle")
                    Text("Upload and Analyze")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $image)
        }
    }

    func uploadImage() {
        guard let image = image else {
            return
        }

        isLoading = true
        errorMessage = nil

        let url = URL(string: "http://raspberrypi5.local:8000/image/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(image.jpegData(compressionQuality: 0.8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        URLSession.shared.uploadTask(with: request, from: data) { responseData, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Upload failed: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }

                guard let responseData = responseData else {
                    self.errorMessage = "No response data"
                    self.isLoading = false
                    return
                }

                do {
                    let decodedResult = try JSONDecoder().decode(InferenceResult.self, from: responseData)
                    self.inferenceResult = decodedResult
                } catch {
                    self.errorMessage = "Failed to decode response data: \(error.localizedDescription)"
                }

                self.isLoading = false
            }
        }.resume()
    }
}

struct InferenceResultView: View {
    var result: InferenceResult

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Type: \(result.image_type)")
                .font(.title2)
                .bold()

            HStack {
                Text("Name: \(result.image_name)")
                    .font(.title3)
                Spacer()
                RatingWidget(rating: result.freshness)
            }

            Text("Shelf Life: \(result.shelf_life) \(result.shelf_life_unit)")
                .font(.title3)

            Text("Description: \(result.description)")
                .font(.body)
        }
        .padding()
    }
}

struct RatingWidget: View {
    var rating: Int

    var body: some View {
        HStack {
            ForEach(0..<10) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(index < rating ? .yellow : .gray)
            }
        }
    }
}
