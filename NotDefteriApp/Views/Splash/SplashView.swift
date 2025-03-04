//
//  SplashView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 5.03.2025.
//

import SwiftUI
import Lottie

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(hex: "#7fa1c3")
            
            VStack(spacing: 60){
                Text("Not Defteri")
                    .foregroundColor(.white)
                    .italic()
                    .bold()
                    .font(.custom("LobsterTwo-Italic", size: 36))
                    .frame(width: UIScreen.main.bounds.width)

                
                LottieView(lottieFile: "SplashAnimation")
                    .frame(width: 200, height: 200
                        )
                    
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .controlSize(.regular)
                    .padding(.top,UIScreen.main.bounds.height * 0.10)
                
                
                
            }
            
        
            
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    SplashView()
}




struct LottieView: UIViewRepresentable {
    let lottieFile: String
 
    var animationView = LottieAnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
