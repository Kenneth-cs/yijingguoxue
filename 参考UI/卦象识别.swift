import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              ZStack() {
                Text("当前进度")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                  .tracking(0.60)
                  .lineSpacing(16)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 50.41, height: 16)
              .offset(x: 0, y: -16)
              ZStack() {
                Text("07 ")
                  .font(Font.custom("Inter", size: 24).weight(.bold))
                  .lineSpacing(32)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: -9.70, y: -0.50)
                Text("/ 10")
                  .font(Font.custom("Inter", size: 14))
                  .lineSpacing(20)
                  .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                  .offset(x: 21.91, y: 2.50)
              }
              .frame(width: 50.41, height: 32)
              .offset(x: 0, y: 8)
            }
            .frame(width: 50.41, height: 48)
            .offset(x: -145.80, y: 0)
            ZStack() {
              ZStack() {
                Text("连胜纪录")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                  .tracking(0.60)
                  .lineSpacing(16)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 50.41, height: 16)
              .offset(x: 0, y: -16)
              ZStack() {
                VStack(alignment: .leading, spacing: undefined) {

                }
                .offset(x: -9.46, y: 0)
                ZStack() {
                  Text("5")
                    .font(Font.custom("Inter", size: 24).weight(.bold))
                    .lineSpacing(32)
                    .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 14.94, height: 32)
                .offset(x: 6.66, y: 0)
              }
              .frame(width: 28.26, height: 32)
              .offset(x: 11.08, y: 8)
            }
            .frame(width: 50.41, height: 48)
            .offset(x: 145.79, y: 0)
          }
          .frame(width: 342, height: 48)
          .offset(x: 0, y: -60.50)
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 239.39, height: 12)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32))
              .cornerRadius(9999)
              .offset(x: -51.31, y: 0)
          }
          .frame(width: 342, height: 12)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
          .cornerRadius(9999)
          .offset(x: 0, y: -14.50)
          ZStack() {
            ZStack() {
              ZStack() {
                ZStack() {
                  Text("剩余时间")
                    .font(Font.custom("Inter", size: 10).weight(.bold))
                    .lineSpacing(15)
                    .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 85.03, height: 15)
                .offset(x: -0, y: -14)
                ZStack() {
                  Text("00:15")
                    .font(Font.custom("Inter", size: 20).weight(.bold))
                    .lineSpacing(28)
                    .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 49.72, height: 28)
                .offset(x: 0, y: 7.50)
              }
              .frame(width: 166, height: 69)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
              .cornerRadius(12)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .inset(by: 0.50)
                  .stroke(
                    Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
                  )
              )
              .offset(x: -88, y: 0)
              ZStack() {
                ZStack() {
                  Text("准确性")
                    .font(Font.custom("Inter", size: 10).weight(.bold))
                    .lineSpacing(15)
                    .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                    .offset(x: -0.50, y: 0)
                }
                .frame(width: 57.48, height: 15)
                .offset(x: 0, y: -14)
                ZStack() {
                  Text("92%")
                    .font(Font.custom("Inter", size: 20).weight(.bold))
                    .lineSpacing(28)
                    .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                    .offset(x: -0.95, y: 0)
                }
                .frame(width: 42.91, height: 28)
                .offset(x: -0, y: 7.50)
              }
              .frame(width: 164, height: 69)
              .background(Color(red: 0.95, green: 0.96, blue: 0.98))
              .cornerRadius(12)
              .offset(x: 89, y: 0)
            }
            .frame(width: 342, height: 69)
            .offset(x: 0, y: 4)
          }
          .frame(width: 342, height: 77)
          .offset(x: 0, y: 46)
        }
        .frame(width: 390, height: 217)
        .background(.white)
        .offset(x: 0, y: -309)
        ZStack() {
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 320, height: 320)
              .background(Color(red: 1, green: 1, blue: 1).opacity(0))
              .cornerRadius(24)
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0.03, green: 0.42, blue: 0.32, opacity: 0.05), radius: 10, y: 8
              )
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 128, height: 12)
                .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                .cornerRadius(9999)
                .offset(x: 0, y: -60)
              ZStack() {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 60, height: 12)
                  .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .cornerRadius(9999)
                  .offset(x: -34, y: 0)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 60, height: 12)
                  .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .cornerRadius(9999)
                  .offset(x: 34, y: 0)
              }
              .frame(width: 128, height: 12)
              .offset(x: 0, y: -36)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 128, height: 12)
                .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                .cornerRadius(9999)
                .offset(x: 0, y: -12)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 128, height: 12)
                .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                .cornerRadius(9999)
                .offset(x: 0, y: 12)
              ZStack() {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 60, height: 12)
                  .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .cornerRadius(9999)
                  .offset(x: -34, y: 0)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 60, height: 12)
                  .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .cornerRadius(9999)
                  .offset(x: 34, y: 0)
              }
              .frame(width: 128, height: 12)
              .offset(x: 0, y: 36)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 128, height: 12)
                .background(Color(red: 0.06, green: 0.09, blue: 0.16))
                .cornerRadius(9999)
                .offset(x: 0, y: 60)
            }
            .frame(width: 128, height: 132)
            .offset(x: 0, y: 0)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 316, height: 316)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32))
              .cornerRadius(24)
              .offset(x: 0, y: 0)
            ZStack() {
              ZStack() {
                ZStack() {
                  Text("STEP 7")
                    .font(Font.custom("Inter", size: 10).weight(.bold))
                    .lineSpacing(15)
                    .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 57.89, height: 23)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
                .cornerRadius(9999)
                .offset(x: 0, y: -4)
              }
              .frame(width: 57.89, height: 31)
              .offset(x: 0, y: -10)
              ZStack() {
                Text("快速识别当前卦象")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.medium))
                  .lineSpacing(20)
                  .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 112, height: 20)
              .offset(x: 0, y: 15.50)
            }
            .frame(width: 112, height: 51)
            .offset(x: 0, y: 108.50)
          }
          .frame(width: 320, height: 320)
          .background(.white)
          .cornerRadius(24)
          .overlay(
            RoundedRectangle(cornerRadius: 24)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20), lineWidth: 1
              )
          )
          .offset(x: 0, y: -88)
          ZStack() {
            ZStack() {
              ZStack() {
                Text("水雷屯")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
                  .lineSpacing(28)
                  .foregroundColor(Color(red: 0.12, green: 0.16, blue: 0.23))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 54, height: 28)
              .offset(x: 0, y: 0)
            }
            .frame(width: 163, height: 64)
            .background(.white)
            .cornerRadius(12)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 1)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 1)
            )
            .offset(x: -89.50, y: -40)
            ZStack() {
              ZStack() {
                Text("山水蒙")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
                  .lineSpacing(28)
                  .foregroundColor(Color(red: 0.12, green: 0.16, blue: 0.23))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 54, height: 28)
              .offset(x: 0, y: 0)
            }
            .frame(width: 163, height: 64)
            .background(.white)
            .cornerRadius(12)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 1)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 1)
            )
            .offset(x: 89.50, y: -40)
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 163, height: 64)
                .background(Color(red: 1, green: 1, blue: 1).opacity(0))
                .cornerRadius(12)
                .offset(x: 0, y: 0)
                .shadow(
                  color: Color(red: 0.03, green: 0.42, blue: 0.32, opacity: 0.20), radius: 6, y: 4
                )
              ZStack() {
                Text("水天需")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
                  .lineSpacing(28)
                  .foregroundColor(.white)
                  .offset(x: 0, y: 0)
              }
              .frame(width: 54, height: 28)
              .offset(x: 0, y: 0)
            }
            .frame(width: 163, height: 64)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32))
            .cornerRadius(12)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 1)
                .stroke(Color(red: 0.03, green: 0.42, blue: 0.32), lineWidth: 1)
            )
            .offset(x: -89.50, y: 40)
            ZStack() {
              ZStack() {
                Text("天水讼")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
                  .lineSpacing(28)
                  .foregroundColor(Color(red: 0.12, green: 0.16, blue: 0.23))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 54, height: 28)
              .offset(x: 0, y: 0)
            }
            .frame(width: 163, height: 64)
            .background(.white)
            .cornerRadius(12)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: 1)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 1)
            )
            .offset(x: 89.50, y: 40)
          }
          .frame(width: 342, height: 144)
          .offset(x: 0, y: 189)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: -94, y: -0.01)
            ZStack() {
              Text("提示：注意观察阴阳爻的排列顺序")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.60))
                .offset(x: 0, y: 0)
            }
            .frame(width: 180, height: 16)
            .offset(x: 10.56, y: 0)
          }
          .frame(width: 390, height: 48)
          .offset(x: -4, y: 93)
        }
        .frame(width: 390, height: 544)
        .offset(x: 0, y: 71.50)
        ZStack() {
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 22, height: 32)
            .offset(x: 0, y: -11)
            ZStack() {
              Text("学堂")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .tracking(0.30)
                .lineSpacing(18)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 24.61, height: 18)
            .offset(x: -0.01, y: 18)
          }
          .frame(width: 114, height: 54)
          .offset(x: -122, y: -11.50)
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 18, height: 32)
            .offset(x: 0, y: -11)
            ZStack() {
              Text("挑战")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.bold))
                .tracking(0.30)
                .lineSpacing(18)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 0, y: 0)
            }
            .frame(width: 24.61, height: 18)
            .offset(x: -0.01, y: 18)
          }
          .frame(width: 114, height: 54)
          .offset(x: 0, y: -11.50)
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 16, height: 32)
            .offset(x: 0, y: -11)
            ZStack() {
              Text("我的")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .tracking(0.30)
                .lineSpacing(18)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 24.61, height: 18)
            .offset(x: -0.01, y: 18)
          }
          .frame(width: 114, height: 54)
          .offset(x: 122, y: -11.50)
        }
        .frame(width: 390, height: 95)
        .background(.white)
        .overlay(
          Rectangle()
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: 0, y: 443)
        ZStack() {
          ZStack() {
            ZStack() {
              Text("卦象识别挑战")
                .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
                .lineSpacing(22.50)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: 0, y: 0)
            }
            .frame(width: 105.31, height: 23)
            .offset(x: 0.34, y: 0)
          }
          .frame(width: 110, height: 23)
          .offset(x: 0, y: 1)
          ZStack() {
            VStack(spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 40, height: 40)
          .offset(x: -167, y: 0.50)
        }
        .frame(width: 390, height: 73)
        .background(.white)
        .overlay(
          Rectangle()
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: 0, y: -454)
        Text("跳过此题")
          .font(Font.custom("Noto Sans SC", size: 16).weight(.medium))
          .lineSpacing(24)
          .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.60))
          .offset(x: 2.01, y: 362.50)
      }
      .frame(width: 390, height: 981)
      .offset(x: 0, y: 0)
    }
    .frame(width: 390, height: 981)
    .background(Color(red: 0.96, green: 0.97, blue: 0.97));
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}