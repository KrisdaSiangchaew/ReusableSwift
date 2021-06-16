//
//  RemoteImage.swift
//  RemoteImage
//
//  Created by Kris Siangchaew on 15/10/2563 BE.
//

import SwiftUI

struct RemoteImage: View {
    enum LoadingState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadingState.loading
        
        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid url: \(url)")
            }
            
            URLSession.shared.dataTask(with: parsedURL) { (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data, data.count > 0 {
                        self.data = data
                        self.state = .success
                    } else {
                        self.state = .failure
                    }
                    
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "mulitply.circle")) {
        self.loading = loading
        self.failure = failure
        _loader = StateObject(wrappedValue: Loader(url: url))
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .failure: return failure
        case .loading: return loading
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
    
    var body: some View {
        selectImage()
            .resizable()
    }
}
