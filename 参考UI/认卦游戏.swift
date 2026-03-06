import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 390, height: 889)
        .background(Color(red: 1, green: 1, blue: 1).opacity(0))
        .offset(x: 0, y: 0)
        .shadow(
          color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 10, y: 8
        )
      ZStack() {
        ZStack() {
          VStack(alignment: .leading, spacing: undefined) {

          }
          .offset(x: 0, y: 0)
        }
        .frame(width: 40, height: 40)
        .cornerRadius(9999)
        .offset(x: -159, y: 3.50)
        ZStack() {
          Text("认卦游戏")
            .font(Font.custom("Noto Sans SC", size: 18).weight(.bold))
            .lineSpacing(22.50)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: 0.50, y: 0)
        }
        .frame(width: 278, height: 23)
        .offset(x: 0, y: 3.50)
      }
      .frame(width: 390, height: 65)
      .background(.white)
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(
            Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
          )
      )
      .offset(x: 0, y: -412)
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              Text("当前进度")
                .font(Font.custom("Noto Sans SC", size: 12).weight(.medium))
                .tracking(0.60)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.70))
                .offset(x: -0.20, y: 0)
            }
            .frame(width: 50.41, height: 16)
            .offset(x: 0, y: -13.75)
            ZStack() {
              Text("1")
                .font(Font.custom("Inter", size: 24).weight(.bold))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -20.02, y: -2)
              Text("/10")
                .font(Font.custom("Inter", size: 18))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: -2.26, y: 0)
            }
            .frame(width: 50.41, height: 28)
            .offset(x: 0, y: 7.75)
          }
          .frame(width: 50.41, height: 43.50)
          .offset(x: -145.80, y: 0)
          ZStack() {
            ZStack() {
              Text("当前得分")
                .font(Font.custom("Noto Sans SC", size: 12).weight(.medium))
                .tracking(0.60)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.70))
                .offset(x: -0.20, y: 0)
            }
            .frame(width: 50.41, height: 16)
            .offset(x: 0, y: -12)
            ZStack() {
              Text("0")
                .font(Font.custom("Inter", size: 24).weight(.bold))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 17.11, y: 0)
            }
            .frame(width: 50.41, height: 24)
            .offset(x: 0, y: 8)
          }
          .frame(width: 50.41, height: 40)
          .offset(x: 145.79, y: 1.75)
        }
        .frame(width: 342, height: 43.50)
        .offset(x: 0, y: -10)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 34.19, height: 8)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32))
            .cornerRadius(9999)
            .offset(x: -153.91, y: 0)
        }
        .frame(width: 342, height: 8)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
        .cornerRadius(9999)
        .offset(x: 0, y: 27.75)
      }
      .frame(width: 390, height: 111.50)
      .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
      .offset(x: 0, y: -323.75)
      ZStack() {
        ZStack() {
          Text("识其形，辩其义")
            .font(Font.custom("Noto Sans SC", size: 16).weight(.medium))
            .lineSpacing(24)
            .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.80))
            .offset(x: -0.01, y: -2)
        }
        .frame(width: 112.02, height: 28)
        .offset(x: -0.01, y: 98)
        ZStack() {
          Text("请选择正确的卦名")
            .font(Font.custom("Noto Sans SC", size: 20).weight(.bold))
            .lineSpacing(28)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: 0, y: 0)
        }
        .frame(width: 160, height: 28)
        .offset(x: 0, y: 126)
        ZStack() {
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 188, height: 188)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
              .cornerRadius(24)
              .offset(x: 0, y: 0)
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 192, height: 192)
          .background(Color(red: 0.96, green: 0.97, blue: 0.97))
          .cornerRadius(24)
          .overlay(
            RoundedRectangle(cornerRadius: 24)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 1
              )
          )
          .offset(x: 0, y: -16)
        }
        .frame(width: 192, height: 224)
        .offset(x: 0, y: -28)
      }
      .frame(width: 390, height: 376)
      .offset(x: 0, y: -80)
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              Text("讼 (Sòng)")
                .font(Font.custom("Inter", size: 18).weight(.bold))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 0, y: 0)
            }
            .frame(width: 81.25, height: 28)
            .offset(x: 0, y: 0)
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 65.67, y: -16.16)
          }
          .frame(width: 163, height: 64)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(Color(red: 0.03, green: 0.42, blue: 0.32), lineWidth: 1)
          )
          .offset(x: -89.50, y: -40)
          ZStack() {
            ZStack() {
              Text("咸 (Xián)")
                .font(Font.custom("Inter", size: 18).weight(.bold))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 0, y: 0)
            }
            .frame(width: 75.66, height: 28)
            .offset(x: 0, y: 0)
          }
          .frame(width: 163, height: 64)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 1
              )
          )
          .offset(x: 89.50, y: -40)
          ZStack() {
            ZStack() {
              Text("旅 (Lǚ)")
                .font(Font.custom("Inter", size: 18).weight(.bold))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 0, y: 0)
            }
            .frame(width: 57.22, height: 28)
            .offset(x: 0, y: 0)
          }
          .frame(width: 163, height: 64)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 1
              )
          )
          .offset(x: -89.50, y: 40)
          ZStack() {
            ZStack() {
              Text("丰 (Fēng)")
                .font(Font.custom("Inter", size: 18).weight(.bold))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 0, y: 0)
            }
            .frame(width: 79.19, height: 28)
            .offset(x: 0, y: 0)
          }
          .frame(width: 163, height: 64)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 1
              )
          )
          .offset(x: 89.50, y: 40)
        }
        .frame(width: 390, height: 144)
        .offset(x: 0, y: -16)
      }
      .frame(width: 390, height: 176)
      .offset(x: 0, y: 196)
      ZStack() {
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 342, height: 56)
            .background(Color(red: 1, green: 1, blue: 1).opacity(0))
            .cornerRadius(12)
            .offset(x: 0, y: 0)
            .shadow(
              color: Color(red: 0.03, green: 0.42, blue: 0.32, opacity: 0.20), radius: 6, y: 4
            )
          Text("提交答案")
            .font(Font.custom("Noto Sans SC", size: 16).weight(.bold))
            .lineSpacing(24)
            .foregroundColor(.white)
            .offset(x: -0.01, y: 0)
        }
        .frame(width: 342, height: 56)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32))
        .cornerRadius(12)
        .offset(x: 0, y: -52)
        ZStack() {
          Text("跳过此题")
            .font(Font.custom("Noto Sans SC", size: 16).weight(.medium))
            .lineSpacing(24)
            .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.60))
            .offset(x: -0.01, y: 0)
        }
        .frame(width: 342, height: 40)
        .offset(x: 0, y: 12)
      }
      .frame(width: 390, height: 160)
      .offset(x: 0, y: 364)
    }
    .frame(width: 390, height: 889)
    .background(.white);
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}