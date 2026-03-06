import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      ZStack() {
        ZStack() {
          Text("个人中心")
            .font(Font.custom("WenQuanYi Zen Hei", size: 30).weight(.bold))
            .lineSpacing(36)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: -112.50, y: 0)
        }
        .frame(width: 342, height: 36)
        .offset(x: 0, y: -515.50)
        ZStack() {
          ZStack() {
            ZStack() {
              Text("易经学者")
                .font(Font.custom("Song Myung", size: 20))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -2.79, y: 0)
            }
            .frame(width: 85.58, height: 28)
            .offset(x: 0, y: 0)
          }
          .frame(width: 85.58, height: 48)
          .offset(x: -15.21, y: 2)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 51.51, y: 0)
          }
          .frame(width: 110.42, height: 12)
          .offset(x: 98.79, y: 2)
        }
        .frame(width: 342, height: 114)
        .background(.white)
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: 0, y: -416.50)
        .shadow(
          color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
        )
        ZStack() {
          ZStack() {
            ZStack() {
              Text("已学完")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .tracking(0.60)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: 0, y: 0)
            }
            .frame(width: 129, height: 16)
            .offset(x: 0, y: -18)
            ZStack() {
              Text("6")
                .font(Font.custom("Noto Serif", size: 24).weight(.bold))
                .lineSpacing(32)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -57.50, y: 0)
            }
            .frame(width: 129, height: 32)
            .offset(x: 0, y: 10)
          }
          .frame(width: 163, height: 86)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 0.50)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
              )
          )
          .offset(x: -89.50, y: -55)
          ZStack() {
            ZStack() {
              Text("我的收藏")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .tracking(0.60)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: 0, y: 0)
            }
            .frame(width: 129, height: 16)
            .offset(x: 0, y: -18)
            ZStack() {
              Text("0")
                .font(Font.custom("Noto Serif", size: 24).weight(.bold))
                .lineSpacing(32)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -57.50, y: 0)
            }
            .frame(width: 129, height: 32)
            .offset(x: 0, y: 10)
          }
          .frame(width: 163, height: 86)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 0.50)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
              )
          )
          .offset(x: 89.50, y: -55)
          ZStack() {
            ZStack() {
              Text("连续天数")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .tracking(0.60)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: 0, y: 0)
            }
            .frame(width: 129, height: 16)
            .offset(x: 0, y: -18)
            ZStack() {
              Text("1")
                .font(Font.custom("Noto Serif", size: 24).weight(.bold))
                .lineSpacing(32)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -57.50, y: 0)
            }
            .frame(width: 129, height: 32)
            .offset(x: 0, y: 10)
          }
          .frame(width: 163, height: 86)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 0.50)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
              )
          )
          .offset(x: -89.50, y: 47)
          ZStack() {
            ZStack() {
              Text("学习时长")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                .tracking(0.60)
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: 0, y: 0)
            }
            .frame(width: 129, height: 16)
            .offset(x: 0, y: -18)
            ZStack() {
              Text("10")
                .font(Font.custom("Song Myung", size: 24))
                .lineSpacing(32)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -52.50, y: 0)
              Text("分钟")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.60))
                .offset(x: 47.50, y: 4)
            }
            .frame(width: 129, height: 32)
            .offset(x: 0, y: 10)
          }
          .frame(width: 163, height: 86)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 0.50)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
              )
          )
          .offset(x: 89.50, y: 47)
        }
        .frame(width: 390, height: 196)
        .offset(x: 0, y: -237.50)
        ZStack() {
          ZStack() {
            Text("学习中心")
              .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.bold))
              .tracking(1.40)
              .lineSpacing(20)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: 0, y: 0)
          }
          .frame(width: 342, height: 20)
          .offset(x: 0, y: -112)
          ZStack() {
            ZStack() {
              ZStack() {
                VStack(alignment: .leading, spacing: undefined) {

                }
                .offset(x: 0, y: 0)
              }
              .frame(width: 40, height: 40)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
              .cornerRadius(8)
              .offset(x: -134, y: -0.50)
              ZStack() {
                Text("我的收藏")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 228.60, height: 24)
              .offset(x: 16.30, y: -0.50)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 150.30, y: -0.50)
            }
            .frame(width: 340, height: 73)
            .overlay(
              Rectangle()
                .inset(by: 0.50)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 0.50)
            )
            .offset(x: 0, y: -72.50)
            ZStack() {
              ZStack() {
                VStack(alignment: .leading, spacing: undefined) {

                }
                .offset(x: 0, y: 0)
              }
              .frame(width: 40, height: 40)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
              .cornerRadius(8)
              .offset(x: -134, y: -0.50)
              ZStack() {
                Text("学习笔记")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 228.60, height: 24)
              .offset(x: 16.30, y: -0.50)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 150.30, y: -0.50)
            }
            .frame(width: 340, height: 73)
            .overlay(
              Rectangle()
                .inset(by: 0.50)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 0.50)
            )
            .offset(x: 0, y: 0.50)
            ZStack() {
              ZStack() {
                VStack(alignment: .leading, spacing: undefined) {

                }
                .offset(x: 0, y: 0)
              }
              .frame(width: 40, height: 40)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
              .cornerRadius(8)
              .offset(x: -134, y: 0)
              ZStack() {
                Text("练习记录")
                  .font(Font.custom("Song Myung", size: 16))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: -82.30, y: 0)
              }
              .frame(width: 228.60, height: 24)
              .offset(x: 16.30, y: 0)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 150.30, y: 0)
            }
            .frame(width: 340, height: 72)
            .offset(x: 0, y: 73)
          }
          .frame(width: 342, height: 220)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 0.50)
              .stroke(Color(red: 0.89, green: 0.91, blue: 0.94), lineWidth: 0.50)
          )
          .offset(x: 0, y: 20)
        }
        .frame(width: 390, height: 260)
        .offset(x: 0, y: 14.50)
        ZStack() {
          ZStack() {
            Text("应用设置")
              .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.bold))
              .tracking(1.40)
              .lineSpacing(20)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: 0, y: 0)
          }
          .frame(width: 342, height: 20)
          .offset(x: 0, y: -116.50)
          ZStack() {
            ZStack() {
              ZStack() {
                Text("关于应用")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 284.60, height: 24)
              .offset(x: -11.70, y: -0.50)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 150.30, y: -0.50)
            }
            .frame(width: 340, height: 57)
            .overlay(
              Rectangle()
                .inset(by: 0.50)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 0.50)
            )
            .offset(x: 0, y: -85)
            ZStack() {
              ZStack() {
                Text("隐私政策")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 284.60, height: 24)
              .offset(x: -11.70, y: -0.50)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 150.30, y: -0.50)
            }
            .frame(width: 340, height: 57)
            .overlay(
              Rectangle()
                .inset(by: 0.50)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 0.50)
            )
            .offset(x: 0, y: -28)
            ZStack() {
              ZStack() {
                Text("用户协议")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 284.60, height: 24)
              .offset(x: -11.70, y: -0.50)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 150.30, y: -0.50)
            }
            .frame(width: 340, height: 57)
            .overlay(
              Rectangle()
                .inset(by: 0.50)
                .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 0.50)
            )
            .offset(x: 0, y: 29)
            ZStack() {
              ZStack() {
                Text("分享应用")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                  .lineSpacing(24)
                  .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 274, height: 24)
              .offset(x: -17, y: 0)
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 145, y: 0)
            }
            .frame(width: 340, height: 56)
            .offset(x: 0, y: 85.50)
          }
          .frame(width: 342, height: 229)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 0.50)
              .stroke(Color(red: 0.89, green: 0.91, blue: 0.94), lineWidth: 0.50)
          )
          .offset(x: 0, y: 20)
        }
        .frame(width: 390, height: 269)
        .offset(x: 0, y: 303)
      }
      .frame(width: 390, height: 1131)
      .offset(x: 0, y: 0)
      ZStack() {
        ZStack() {
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: -9.50)
            ZStack() {
              Text("首页")
                .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.bold))
                .lineSpacing(15)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 19, height: 15)
            .offset(x: 0, y: 11)
          }
          .frame(width: 19, height: 37)
          .offset(x: -136.77, y: 0)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: -9.50)
            ZStack() {
              Text("百科")
                .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.bold))
                .lineSpacing(15)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 19, height: 15)
            .offset(x: 0, y: 10)
          }
          .frame(width: 22, height: 35)
          .offset(x: -50.77, y: 0)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: -9.50)
            ZStack() {
              Text("练习")
                .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.bold))
                .lineSpacing(15)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 19, height: 15)
            .offset(x: 0, y: 10)
          }
          .frame(width: 19, height: 35)
          .offset(x: 35.23, y: 0)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: -9.50)
            ZStack() {
              Text("我的")
                .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.bold))
                .lineSpacing(15)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 0, y: 0)
            }
            .frame(width: 19, height: 15)
            .offset(x: 0, y: 10)
          }
          .frame(width: 19, height: 35)
          .offset(x: 119.73, y: 0)
        }
        .frame(width: 358, height: 37)
        .offset(x: 0, y: -5.50)
      }
      .frame(width: 390, height: 74)
      .background(Color(red: 1, green: 1, blue: 1).opacity(0.80))
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(Color(red: 0.89, green: 0.91, blue: 0.94), lineWidth: 0.50)
      )
      .offset(x: 0, y: 528.50)
    }
    .frame(width: 390, height: 1131)
    .background(Color(red: 0.96, green: 0.97, blue: 0.97));
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}image.png